#!/bin/bash

REQ_DEBIAN_VER=13
CUR_DEB_VER=$(grep "VERSION_ID" /etc/os-release | grep -Eo "[0-9]{1,3}")

get_date() {
	echo $(date +%d%m%Y)
}

get_time() {
	echo $(date +%H_%M_%S)
}

START_DATETIME=$(get_date)__$(get_time)
PKG_ERROR_FILE=./PKG_$START_DATETIME.ERR

create_dir() {
	sudo mkdir -p $1 2>/dev/null
}

read_pkgs() {
	echo $(grep -Pv "^#" DEB$REQ_DEBIAN_VER.pkgs | tr "\n" " ")
}

install_pkg() {
	for pkg in $@; do
		sudo apt-get install $pkg -y >/dev/null 2>>$PKG_ERROR_FILE
	done
}

if [ "$EUID" -eq 0 ]; then
	echo "This script must not be run as root. Exiting."
	exit 1
fi

if [ $CUR_DEB_VER -ne $REQ_DEBIAN_VER ]; then
	echo "This script only supports Debian version $REQ_DEBIAN_VER (found version $CUR_DEB_VER). Exiting."
	exit 1
fi

DIR=$HOME/Downloads

create_dir $DIR
sudo apt-get update >/dev/null

echo -e "Installing packages via apt-get...\n"
install_pkg $(read_pkgs)
cat $PKG_ERROR_FILE

if [[ $? -eq 0 ]]; then
	echo -e "\nError while installing apt-get packages. Exiting."
	exit 1
fi

echo "success installing apt-get packages!"

exit 0

# oh my zsh
cd $DIR && sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)" "" --unattended
sudo chsh -s /bin/zsh $USER

# font: dejavu sansm nerd font
cd $DIR && wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/DejaVuSansMono.zip && sudo unzip DejaVuSansMono.zip -d /usr/local/share/fonts
rm $DIR/DejaVuSansMono.zip

# neovim
cd $DIR && git clone https://github.com/neovim/neovim && cd neovim && git checkout stable && make CMAKE_BUILD_TYPE=RelWithDebInfo && cd build && cpack -G DEB

DEBDIR=$(ls $DIR/neovim/build | grep '^nvim.*\.deb$')
sudo dpkg -i $DIR/neovim/build/$DEBDIR

rm $DIR/neovim -rf

# rust
cd $DIR && curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
. "$HOME/.cargo/env"
rustup override set stable && rustup update stable

# alacritty
cd $DIR && git clone https://github.com/alacritty/alacritty.git

cd $DIR/alacritty && cargo build --release --no-default-features --features=x11 && sudo tic -xe alacritty,alacritty-direct extra/alacritty.info && sudo cp target/release/alacritty /usr/local/bin && sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg && sudo desktop-file-install extra/linux/Alacritty.desktop && sudo update-desktop-database

create_dir /usr/local/share/man/man1
create_dir /usr/local/share/man/man5
scdoc <$DIR/alacritty/extra/man/alacritty.1.scd | gzip -c | sudo tee /usr/local/share/man/man1/alacritty.1.gz >/dev/null
scdoc <$DIR/alacritty/extra/man/alacritty-msg.1.scd | gzip -c | sudo tee /usr/local/share/man/man1/alacritty-msg.1.gz >/dev/null
scdoc <$DIR/alacritty/extra/man/alacritty.5.scd | gzip -c | sudo tee /usr/local/share/man/man5/alacritty.5.gz >/dev/null
scdoc <$DIR/alacritty/extra/man/alacritty-bindings.5.scd | gzip -c | sudo tee /usr/local/share/man/man5/alacritty-bindings.5.gz >/dev/null

create_dir ${ZDOTDIR:-~}/.zsh_functions
echo 'fpath+=${ZDOTDIR:-~}/.zsh_functions' >>${ZDOTDIR:-~}/.zshrc

cp $DIR/alacritty/extra/completions/_alacritty ${ZDOTDIR:-~}/.zsh_functions/_alacritty

rm $DIR/alacritty -rf

# change alacritty to default terminal
sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator /usr/local/bin/alacritty 50

# install xidlehook
cargo install xidlehook --bins

# copy dotfiles
cp ~/.dotfiles/.config ~ -R
cp ~/.dotfiles/.oh-my-zsh ~ -R
cp ~/.dotfiles/.xinitrc ~
cp ~/.dotfiles/.zprofile ~
cp ~/.dotfiles/.zshrc ~

sudo cp ~/.dotfiles/etc/* /etc -R

sudo reboot

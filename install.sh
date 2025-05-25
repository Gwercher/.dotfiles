#!/bin/bash
if [ "$EUID" -eq 0 ]; then
	echo "This script must not be run as root. Exiting."
	exit 1
fi

DIR=/home/$USER/Downloads

mkdir $DIR
sudo apt update
sudo apt install wget curl git xorg unzip xsel tldr neofetch aptitude -y

# zsh
sudo apt install zsh -y

# oh my zsh
cd $DIR && sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)" "" --unattended
sudo chsh -s /bin/zsh $USER

# polybar
sudo apt install polybar -y

# i3
sudo apt install i3 feh -y

# picom
sudo apt install picom -y

# numlockx
sudo apt install numlockx -y

# rofi
sudo apt install rofi -y

# wifi menu (rofi) dependencies
sudo apt install network-manager dunst -y

# pulseaudio
sudo apt install pulseaudio pavucontrol -y

# firefox and thunderbird
sudo apt install firefox-esr thunderbird -y

# libreoffice
sudo apt install libreoffice -y

# cli calendar
sudo apt install calcurse -y

# latex (all packages from texlive-full, minus unused languages)
sudo apt install texlive-base texlive-bibtex-extra texlive-binaries texlive-font-utils texlive-fonts-extra-doc texlive-fonts-extra-links texlive-fonts-extra texlive-fonts-recommended-doc texlive-fonts-recommended texlive-formats-extra texlive-games texlive-humanities-doc texlive-humanities texlive-lang-english texlive-lang-german texlive-latex-base-doc texlive-latex-base texlive-latex-extra-doc texlive-latex-extra texlive-latex-recommended-doc texlive-latex-recommended texlive-luatex texlive-metapost-doc texlive-metapost texlive-music texlive-pictures-doc texlive-pictures texlive-plain-generic texlive-pstricks-doc texlive-pstricks texlive-publishers-doc texlive-publishers texlive-science-doc texlive-science texlive-xetex -y

# audacity
sudo apt install audacity -y

# ranger
sudo apt install ranger -y

# sqlite3 and sqlitebrowser
sudo apt install sqlite3 sqlitebrowser -y

# gimp
sudo apt install gimp -y

# font: dejavu sansm nerd font
cd $DIR && wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/DejaVuSansMono.zip && sudo unzip DejaVuSansMono.zip -d /usr/local/share/fonts

# neovim
sudo apt-get install ninja-build gettext cmake unzip curl build-essential python3.11-venv pip npm -y
cd $DIR && git clone https://github.com/neovim/neovim && cd neovim && git checkout stable && make CMAKE_BUILD_TYPE=RelWithDebInfo && cd build && cpack -G DEB

DEBDIR=$(ls $DIR/neovim/build | grep '^nvim.*\.deb$')
sudo dpkg -i $DIR/neovim/build/$DEBDIR

# rust
sudo apt install cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3 desktop-file-utils -y
cd $DIR && curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
. "$HOME/.cargo/env"
rustup override set stable && rustup update stable

# alacritty
cd $DIR && git clone https://github.com/alacritty/alacritty.git

cd $DIR/alacritty && cargo build --release --no-default-features --features=x11 && sudo tic -xe alacritty,alacritty-direct extra/alacritty.info && sudo cp target/release/alacritty /usr/local/bin && sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg && sudo desktop-file-install extra/linux/Alacritty.desktop && sudo update-desktop-database

sudo apt install gzip scdoc -y

sudo mkdir -p /usr/local/share/man/man1
sudo mkdir -p /usr/local/share/man/man5
scdoc <$DIR/alacritty/extra/man/alacritty.1.scd | gzip -c | sudo tee /usr/local/share/man/man1/alacritty.1.gz >/dev/null
scdoc <$DIR/alacritty/extra/man/alacritty-msg.1.scd | gzip -c | sudo tee /usr/local/share/man/man1/alacritty-msg.1.gz >/dev/null
scdoc <$DIR/alacritty/extra/man/alacritty.5.scd | gzip -c | sudo tee /usr/local/share/man/man5/alacritty.5.gz >/dev/null
scdoc <$DIR/alacritty/extra/man/alacritty-bindings.5.scd | gzip -c | sudo tee /usr/local/share/man/man5/alacritty-bindings.5.gz >/dev/null

mkdir -p ${ZDOTDIR:-~}/.zsh_functions
echo 'fpath+=${ZDOTDIR:-~}/.zsh_functions' >>${ZDOTDIR:-~}/.zshrc

cp $DIR/alacritty/extra/completions/_alacritty ${ZDOTDIR:-~}/.zsh_functions/_alacritty

# change alacritty to default terminal
sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator /usr/local/bin/alacritty 50

# install xidlehook
sudo apt install libxss-dev libxcb-screensaver0-dev -y
cargo install xidlehook --bins

# copy dotfiles
cp ~/.dotfiles/.config ~ -R
cp ~/.dotfiles/.oh-my-zsh ~ -R
cp ~/.dotfiles/.xinitrc ~
cp ~/.dotfiles/.zprofile ~
cp ~/.dotfiles/.zshrc ~

sudo cp ~/.dotfiles/etc/issues /etc/issue

rm $DIR/alacritty -rf
rm $DIR/neovim -rf
rm $DIR/DejaVuSansMono.zip

sudo reboot

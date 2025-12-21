#!/bin/bash
set -e

REQ_DEBIAN_VER=13
CUR_DEB_VER=$(grep "VERSION_ID" /etc/os-release | grep -Eo "[0-9]{1,3}")

START_DATETIME=$(date +%d%m%Y)__$(date +%H_%M_%S)
PKG_ERROR_FILE=./PKG_$START_DATETIME.ERR

DEB_PKGS_FILE=./DEB$REQ_DEBIAN_VER.pkgs
LATEX_PKGS_FILE=./LATEX.pkgs

create_dir() {
	mkdir -p $1 2>/dev/null || sudo mkdir -p $1 2>/dev/null
}

_read_pkgs() {
	echo $(grep -Pv "^#" $1 | tr "\n" " ")
}

install_pkgs() {
	local pkgs=$(_read_pkgs $1)
	local index=1
	local total=$(echo $pkgs | wc -w)

	echo -e "\ninstalling $total apt-get packages from $1"
	for pkg in $pkgs; do
		echo -e "\t$index/$total ... $pkg"
		sudo apt-get install $pkg -y >/dev/null 2>>$PKG_ERROR_FILE
		index=$((index + 1))
	done
}

main() {
	if [ "$EUID" -eq 0 ]; then
		echo "This script must not be run as root. Exiting."
		exit 1
	fi

	if [ $CUR_DEB_VER -ne $REQ_DEBIAN_VER ]; then
		echo "This script only supports Debian version $REQ_DEBIAN_VER (found version $CUR_DEB_VER). Exiting."
		exit 1
	fi

	sudo --validate

	sudo apt-get update >/dev/null

	echo -e "Installing packages via apt-get..."
	install_pkgs $DEB_PKGS_FILE
	install_pkgs $LATEX_PKGS_FILE

	if [ ! -s $ERR_FILE_SIZE ]; then
		cat $PKG_ERROR_FILE
		echo -e "\nError while installing apt-get packages. Exiting."
		exit 1
	fi

	rm $PKG_ERROR_FILE 2>/dev/null
	echo -e "success installing apt-get packages!\n"

	# oh my zsh
	sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)" "" --unattended && sudo chsh -s /bin/zsh $USER

	# font: dejavu sansm nerd font
	wget -O /tmp/font.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/DejaVuSansMono.zip &&
		sudo unzip -o /tmp/font.zip -d /usr/local/share/fonts

	# neovim
	git clone https://github.com/neovim/neovim /tmp/neovim &&
		cd /tmp/neovim &&
		git checkout stable &&
		make CMAKE_BUILD_TYPE=RelWithDebInfo &&
		cd build &&
		cpack -G DEB
	local nvim_deb=$(ls /tmp/neovim/build | grep -E "^nvim.*.deb$")
	sudo dpkg -i /tmp/neovim/build/$nvim_deb

	sudo rm /tmp/neovim -rf

	# rust
	cd ~ && curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
	. "$HOME/.cargo/env"
	rustup override set stable && rustup update stable

	# alacritty
	git clone https://github.com/alacritty/alacritty.git /tmp/alacritty &&
		cd /tmp/alacritty && cargo build --release --no-default-features --features=x11 &&
		sudo tic -xe alacritty,alacritty-direct extra/alacritty.info &&
		sudo cp target/release/alacritty /usr/local/bin &&
		sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg &&
		sudo desktop-file-install extra/linux/Alacritty.desktop &&
		sudo update-desktop-database

	create_dir /usr/local/share/man/man1
	create_dir /usr/local/share/man/man5

	scdoc </tmp/alacritty/extra/man/alacritty.1.scd | gzip -c | sudo tee /usr/local/share/man/man1/alacritty.1.gz >/dev/null
	scdoc </tmp/alacritty/extra/man/alacritty-msg.1.scd | gzip -c | sudo tee /usr/local/share/man/man1/alacritty-msg.1.gz >/dev/null
	scdoc </tmp/alacritty/extra/man/alacritty.5.scd | gzip -c | sudo tee /usr/local/share/man/man5/alacritty.5.gz >/dev/null
	scdoc </tmp/alacritty/extra/man/alacritty-bindings.5.scd | gzip -c | sudo tee /usr/local/share/man/man5/alacritty-bindings.5.gz >/dev/null

	create_dir ${ZDOTDIR:-~}/.zsh_functions
	echo 'fpath+=${ZDOTDIR:-~}/.zsh_functions' >>${ZDOTDIR:-~}/.zshrc

	cp /tmp/alacritty/extra/completions/_alacritty ${ZDOTDIR:-~}/.zsh_functions/_alacritty

	# change alacritty to default terminal
	sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator /usr/local/bin/alacritty 50

	# install xidlehook
	cargo install xidlehook --bins

	# copy dotfiles
	cp ~/.dotfiles/.config ~ -R
	cp ~/.dotfiles/.oh-my-zsh ~ -R
	cp ~/.dotfiles/bin/ ~ -R
	cp ~/.dotfiles/.xinitrc ~
	cp ~/.dotfiles/.zprofile ~
	cp ~/.dotfiles/.zshrc ~
	cp ~/.dotfiles/.clang-format ~

	sudo cp ~/.dotfiles/etc/* /etc -R

	sudo reboot
}

main $@

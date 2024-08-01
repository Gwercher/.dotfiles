# dependencies
mkdir ~/Downloads
sudo apt update
sudo apt install sudo wget curl git xorg unzip xsel tldr -y

# zsh
sudo apt install zsh -y

# oh my zsh
cd ~/Downloads && sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)" "" --unattended
sudo chsh -s /bin/zsh $USER

# polybar
sudo apt install polybar -y

# i3
sudo apt install i3 feh -y

# firefox and thunderbird
sudo apt install firefox-esr thunderbird -y

# ranger
sudo apt install ranger -y

# sqlite3 and sqlitebrowser
sudo apt install sqlite3 sqlitebrowser -y

# font: dejavu sansm nerd font
cd ~/Downloads && wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/DejaVuSansMono.zip && sudo unzip DejaVuSansMono.zip -d /usr/local/share/fonts

# neovim
sudo apt-get install ninja-build gettext cmake unzip curl build-essential npm python3.11-venv pip -y
cd ~/Downloads/ && git clone https://github.com/neovim/neovim && cd neovim && git checkout stable && make CMAKE_BUILD_TYPE=RelWithDebInfo && cd build && cpack -G DEB && sudo dpkg -i nvim-linux64.deb

# rust
sudo apt install cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3 desktop-file-utils -y
cd ~/Downloads && curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
. "$HOME/.cargo/env"
rustup override set stable && rustup update stable

# alacritty
cd ~/Downloads && git clone https://github.com/alacritty/alacritty.git

cd ~/Downloads/alacritty && cargo build --release --no-default-features --features=x11 && sudo tic -xe alacritty,alacritty-direct extra/alacritty.info && sudo cp target/release/alacritty /usr/local/bin && sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg && sudo desktop-file-install extra/linux/Alacritty.desktop && sudo update-desktop-database

sudo apt install gzip scdoc -y

sudo mkdir -p /usr/local/share/man/man1
sudo mkdir -p /usr/local/share/man/man5
scdoc <~/Downloads/alacritty/extra/man/alacritty.1.scd | gzip -c | sudo tee /usr/local/share/man/man1/alacritty.1.gz >/dev/null
scdoc <~/Downloads/alacritty/extra/man/alacritty-msg.1.scd | gzip -c | sudo tee /usr/local/share/man/man1/alacritty-msg.1.gz >/dev/null
scdoc <~/Downloads/alacritty/extra/man/alacritty.5.scd | gzip -c | sudo tee /usr/local/share/man/man5/alacritty.5.gz >/dev/null
scdoc <~/Downloads/alacritty/extra/man/alacritty-bindings.5.scd | gzip -c | sudo tee /usr/local/share/man/man5/alacritty-bindings.5.gz >/dev/null

mkdir -p ${ZDOTDIR:-~}/.zsh_functions
echo 'fpath+=${ZDOTDIR:-~}/.zsh_functions' >>${ZDOTDIR:-~}/.zshrc

cp ~/Downloads/alacritty/extra/completions/_alacritty ${ZDOTDIR:-~}/.zsh_functions/_alacritty

# change alacritty to default terminal
sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator /usr/local/bin/alacritty 50

# copy dotfiles
cp ~/.dotfiles/.config ~ -R
cp ~/.dotfiles/.oh-my-zsh ~ -R
cp ~/.dotfiles/.ranger ~ -R
cp ~/.dotfiles/.xinitrc ~
cp ~/.dotfiles/.zprofile ~
cp ~/.dotfiles/.zshrc ~

rm ~/Downloads/alacritty -rf
rm ~/Downloads/neovim -rf
rm ~/Downloads/DejaVuSansMono.zip

echo "change resolution in ~/.config/i3/config"
echo "reboot to see changes"

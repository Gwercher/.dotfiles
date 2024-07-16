# dependencies
sudo apt update
sudo apt install sudo wget git -y
sudo apt install xorg -y

# zsh
sudo apt install zsh -y

# oh my zsh
cd ~/Downloads && sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"

# alacritty
# cd ~/Downloads && git clone https://github.com/alacritty/alacritty.git && cd alacritty
# curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
# rustup override set stable
# rustup update stable
# sudo apt install cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3 -y
#
# cd ~/Downloads/alacritty && cargo build --release && sudo tic -xe alacritty,alacritty-direct extra/alacritty.info
#
# sudo cp target/release/alacritty /usr/local/bin # or anywhere else in $PATH
# sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
# sudo desktop-file-install extra/linux/Alacritty.desktop
# sudo update-desktop-database
#
# sudo apt install gzip scdoc -y
#
# sudo mkdir -p /usr/local/share/man/man1
# sudo mkdir -p /usr/local/share/man/man5
# scdoc <extra/man/alacritty.1.scd | gzip -c | sudo tee /usr/local/share/man/man1/alacritty.1.gz >/dev/null
# scdoc <extra/man/alacritty-msg.1.scd | gzip -c | sudo tee /usr/local/share/man/man1/alacritty-msg.1.gz >/dev/null
# scdoc <extra/man/alacritty.5.scd | gzip -c | sudo tee /usr/local/share/man/man5/alacritty.5.gz >/dev/null
# scdoc <extra/man/alacritty-bindings.5.scd | gzip -c | sudo tee /usr/local/share/man/man5/alacritty-bindings.5.gz >/dev/null
#
# mkdir -p ${ZDOTDIR:-~}/.zsh_functions
# echo 'fpath+=${ZDOTDIR:-~}/.zsh_functions' >>${ZDOTDIR:-~}/.zshrc
#
# cp extra/completions/_alacritty ${ZDOTDIR:-~}/.zsh_functions/_alacritty

# polybar
# sudo apt install build-essential git cmake cmake-data pkg-config python3-sphinx python3-packaging libuv1-dev libcairo2-dev libxcb1-dev libxcb-util0-dev libxcb-randr0-dev libxcb-composite0-dev python3-xcbgen xcb-proto libxcb-image0-dev libxcb-ewmh-dev libxcb-icccm4-dev -y
# sudo apt install libxcb-xkb-dev libxcb-xrm-dev libxcb-cursor-dev libasound2-dev libpulse-dev i3-wm libjsoncpp-dev libmpdclient-dev libcurl4-openssl-dev libnl-genl-3-dev -y
# cd ~/Downloads/ && git clone --recursive https://github.com/polybar/polybar && cd polybar && mkdir build && cd build && cmake .. && make -j$(nproc) && sudo make install
sudo apt install polybar

# neovim
sudo sudo apt-get install ninja-build gettext cmake unzip curl build-essential -y
cd ~/Downloads/ && git clone https://github.com/neovim/neovim && cd neovim && make CMAKE_BUILD_TYPE=RelWithDebInfo && git checkout stable && cd build && cpack -G DEB && sudo dpkg -i nvim-linux64.deb

# i3
sudo apt install i3 -y

# firefox
sudo apt install firefox-esr -y

#ranger
sudo apt install ranger -y

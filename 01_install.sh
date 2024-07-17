# dependencies
mkdir ~/Downloads
sudo apt update
sudo apt install sudo wget git xorg unzip -y

# zsh
sudo apt install zsh -y

# polybar
# sudo apt install build-essential git cmake cmake-data pkg-config python3-sphinx python3-packaging libuv1-dev libcairo2-dev libxcb1-dev libxcb-util0-dev libxcb-randr0-dev libxcb-composite0-dev python3-xcbgen xcb-proto libxcb-image0-dev libxcb-ewmh-dev libxcb-icccm4-dev -y
# sudo apt install libxcb-xkb-dev libxcb-xrm-dev libxcb-cursor-dev libasound2-dev libpulse-dev i3-wm libjsoncpp-dev libmpdclient-dev libcurl4-openssl-dev libnl-genl-3-dev -y
# cd ~/Downloads/ && git clone --recursive https://github.com/polybar/polybar && cd polybar && mkdir build && cd build && cmake .. && make -j$(nproc) && sudo make install
sudo apt install polybar -y

# i3
sudo apt install i3 feh -y

# firefox
sudo apt install firefox-esr -y

#ranger
sudo apt install ranger -y

# font: dejavu sansm nerd font
cd ~/Downloads && wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/DejaVuSansMono.zip && sudo unzip DejaVuSansMono.zip -d /usr/local/share/fonts

# oh my zsh
cd ~/Downloads && sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"

# neovim
sudo apt-get install ninja-build gettext cmake unzip curl build-essential -y
cd ~/Downloads/ && git clone https://github.com/neovim/neovim && cd neovim && make CMAKE_BUILD_TYPE=RelWithDebInfo && git checkout stable && cd build && cpack -G DEB && sudo dpkg -i nvim-linux64.deb

echo "\n\n\n\033[0;31mNEXT: 03_install_rust.sh"

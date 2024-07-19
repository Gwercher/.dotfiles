# rust
sudo apt install cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3 desktop-file-utils -y
cd ~/Downloads && curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

#experimental
source ~/.zshrc
rustup override set stable && rustup update stable

echo "\n\n\n"
echo "\033[0;31mMANUAL RELOAD USING 'omz reload' NEEDED!"
echo "\n\033[0;31mNEXT: 04_install_alacritty.sh"

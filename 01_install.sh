# dependencies
mkdir ~/Downloads
sudo apt update
sudo apt install sudo wget curl git xorg unzip -y

# zsh
sudo apt install zsh -y

# oh my zsh
cd ~/Downloads && sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)" "" --unattended
zsh && chsh -s /bin/zsh && source ~/.zshrc

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

echo -e "\n\n\n\033[0;31mNEXT: 02_install_nvim.sh"

# alacritty
rustup override set stable && rustup update stable
cd ~/Downloads && git clone https://github.com/alacritty/alacritty.git

cd ~/Downloads/alacritty && cargo build --release && sudo tic -xe alacritty,alacritty-direct extra/alacritty.info && sudo cp target/release/alacritty /usr/local/bin && sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg && sudo desktop-file-install extra/linux/Alacritty.desktop && sudo update-desktop-database

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
# sudo update-alternatives --config x-terminal-emulator

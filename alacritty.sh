#!/bin/bash
set -e

install_alacritty() {
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

  echo 'fpath+=${ZDOTDIR:-~}/.zsh_functions' >>${ZDOTDIR:-~}/.zshrc

  cp /tmp/alacritty/extra/completions/_alacritty ${ZDOTDIR:-~}/.zsh_functions/_alacritty

  # change alacritty to default terminal
  sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator /usr/local/bin/alacritty 50

  sudo rm /tmp/alacritty -rf
}

main() {
  if [ "$EUID" -eq 0 ]; then
    echo "This script must not be run as root. Exiting."
    exit 1
  fi

  sudo --validate

  install_alacritty
}

main $@

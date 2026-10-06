#!/bin/bash

install_nvim() {
  git clone https://github.com/neovim/neovim /tmp/neovim &&
    cd /tmp/neovim &&
    git checkout stable &&
    make CMAKE_BUILD_TYPE=RelWithDebInfo &&
    cd build &&
    cpack -G DEB
  local nvim_deb=$(ls /tmp/neovim/build | grep -E "^nvim.*.deb$")
  sudo dpkg -i /tmp/neovim/build/$nvim_deb

  sudo rm /tmp/neovim -rf
}

main() {
  if [ "$EUID" -eq 0 ]; then
    echo "This script must not be run as root. Exiting."
    exit 1
  fi

  sudo --validate

  install_nvim
}

main $@

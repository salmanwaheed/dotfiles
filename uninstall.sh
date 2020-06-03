#!/bin/bash

set -e

sudo apt remove --purge -y zsh vim
sudo rm -rf $VIM_DIR $ZSHRC $TMP_DIR ~/.vim* ~/.zsh* $ZSH
sudo chsh -s $(which bash) && echo "your default terminal now bash not zsh"
echo "All gone :)"

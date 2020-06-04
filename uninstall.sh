#!/bin/bash

set -e

bash-lib rm_pkg zsh
bash-lib rm_pkg vim
sudo rm -rf $VIM_DIR $ZSHRC $TMP_DIR ~/.vim* ~/.zsh* $ZSH
sudo chsh -s $(which bash) && echo "your default terminal now bash not zsh"
echo "All gone :)"

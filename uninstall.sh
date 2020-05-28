#!/bin/bash

set -e

source common

if command_exists zsh git vim; then
    remove_package zsh
    remove_package git
    remove_package vim

    sudo rm -rf $VIM_DIR $ZSHRC $TMP_DIR ~/.vim* ~/.zsh* $ZSH

    sudo chsh -s $(which bash) && echo "your default terminal now bash not zsh"
    echo "All gone :)"
else
    echo "Nothing is there to uninstalled."
fi

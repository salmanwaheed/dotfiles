#!/bin/bash

set -e

VIM_DIR=$HOME/.vim
VIM_AUTOLOAD_DIR=$VIM_DIR/autoload
VIM_PLUG_FILE=$VIM_AUTOLOAD_DIR/plug.vim
ZSHRC=$HOME/.zshrc
TMP_DIR=$HOME/tmp

# git section
bash-lib ins_pkg git

# vim section
bash-lib ins_pkg vim

if [[ ! -f $VIM_PLUG_FILE ]]; then
    echo "installing vim plugins..."
    sudo curl -fsLo $VIM_PLUG_FILE --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim >/dev/null 2>&1
fi

if [[ -d "$VIM_DIR" ]]; then
    echo "setting vim's configrations..."

    # give access to current user
    sudo chown -R $USER "$VIM_DIR"

    # copy mandatory files
    sudo cp -run ./.vim/* "$VIM_DIR"

    # install if any plugin exist in vimrc.plug file
    sudo vim +PlugInstall +qall

    # symbolic link
    if [[ -f "$VIM_DIR/vimrc" ]]; then
      sudo ln -sf "$VIM_DIR/vimrc" "$HOME/.vimrc"
    else
      echo "vimrc canot be found!"
      exit
    fi

    echo "vim has been installed successfully!"
fi

# https://github.com/ohmyzsh/ohmyzsh/wiki
# https://gist.github.com/dogrocker/1efb8fd9427779c827058f873b94df95
# install zsh for linux
# will change it later for cross platform
# bash-lib ins_pkg zsh

# install oh-my-zsh
#if [[ ! -d $ZSH ]]; then
#  echo "installing oh-my-zsh..."
#  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
#fi

if [[ -d $ZSH ]]; then
  echo "setting vim's configrations..."

  # https://github.com/dracula/zsh
  rm -rf $TMP_DIR && mkdir -p $TMP_DIR
  git clone https://github.com/dracula/zsh.git $TMP_DIR
  cp $TMP_DIR/dracula.zsh-theme $ZSH/themes/
  cp -r $TMP_DIR/lib $ZSH/themes/
  sudo chown -R $USER $ZSH

  # add some plugins
  git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH/custom/plugins/zsh-autosuggestions
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH/custom/plugins/zsh-syntax-highlighting

  sed -i 's/robbyrussell/dracula/g' $ZSHRC
  sed -i 's/git/git zsh-autosuggestions zsh-syntax-highlighting/' $ZSHRC
  sed -i 's/source $ZSH\/oh-my-zsh.sh/ZSH_DISABLE_COMPFIX=true\'$'\nsource $ZSH\\/oh-my-zsh.sh/' $ZSHRC
  echo 'DISABLE_AUTO_TITLE=true' >> $ZSHRC
else
  echo "oh-my-zsh is not installed yet."
  exit
fi

echo 'winding up....'

# remove tmp dir
rm -rf $TMP_DIR && echo "tmp dir has been removed!"

# final message
echo "all done :). reopen your terminal to see changes.."

# make default shell
# chsh -s $(which zsh)

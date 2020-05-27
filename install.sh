#!/bin/bash

set -e

# brew install vim
# sudo apt install vim

export VIM_DIR=$HOME/.vim
export VIM_PLUG_DIR=$VIM_DIR/autoload/plug.vim
export ZSHRC=$HOME/.zshrc
export TMP_DIR=$HOME/tmp

echo "installing vim..."

sudo curl -fLo $VIM_PLUG_DIR --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

if [[ -d "$VIM_DIR" ]]; then
  # give access to current user
  sudo chown -R $USER "$VIM_DIR"

  # copy mandatory files
  sudo cp -r ./.vim/* "$VIM_DIR"

  # install if any plugin exist in vimrc.plug file
  sudo vim +PlugInstall +qall

  # symbolic link
  if [[ -f "$VIM_DIR/vimrc" ]]; then
    sudo ln -sf "$VIM_DIR/vimrc" "$HOME/.vimrc"
  else
    echo "vimrc canot be found!"
    exit
  fi

  # message
  echo "vim has been installed successfully! :)"
  echo
else
  echo "$VIM_DIR not exist"
  exit
fi

sleep 1

# https://github.com/ohmyzsh/ohmyzsh/wiki
# https://gist.github.com/dogrocker/1efb8fd9427779c827058f873b94df95
echo "installing oh-my-zsh..."

# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

if [[ -d $ZSH ]]; then
  # https://github.com/dracula/zsh
  mkdir $TMP_DIR
  git clone https://github.com/dracula/zsh.git $TMP_DIR
  mv $TMP_DIR/dracula.zsh-theme $ZSH/themes/
  mv $TMP_DIR/lib $ZSH/themes/

  # add some plugins
  git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting

  sed -i 's/robbyrussell/dracula/g' $ZSHRC
  sed -i 's/git/git zsh-autosuggestions zsh-syntax-highlighting/' $ZSHRC
  sed -i 's/source $ZSH\/oh-my-zsh.sh/ZSH_DISABLE_COMPFIX=true\'$'\nsource $ZSH\\/oh-my-zsh.sh/' $ZSHRC
  echo 'DISABLE_AUTO_TITLE=true' >> $ZSHRC
else
  echo "zsh does not install properly. reinstall it..."
  exit
fi

echo 
echo 'winding up....'

# make default shell
chsh -s $(which zsh) && echo 'you are using zsh terminal now!'
echo

# remove tmp dir
rm -rf $TMP_DIR && echo "tmp dir has been removed!"
echo 

# final message
echo "all done :). reopen your terminal to see changes.."

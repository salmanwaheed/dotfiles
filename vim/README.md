# vim

**Linux (Debian, Ubuntu, Mint)**
```bash
sudo apt install -y vim
```

**MacOSx** _(don't forget to install [Homebrew](https://brew.sh/) if you don't have one)_
```bash
brew install vim
```

1. Clone this repository on your Desktop folder.
1. Run the following commands to setup.

```sh
# Download Package Manager for plugins
sudo curl -fsLo $HOME/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# option 1
sudo cp -r ~/Desktop/dotfiles/vim/* ~/.vim/

# option 2
ln -sf ~/Desktop/dotfiles/vim/vimrc ~/.vimrc
ln -sf ~/Desktop/dotfiles/vim/vimrc.plug ~/.vim/vimrc.plug

# if you get an ownership error,
# then run following code,
# to change onwership.
sudo chown -R $USER ~/.vim

# Install Plugins
sudo vim +PlugInstall +qall
```

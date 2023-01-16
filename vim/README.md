# vim

**Linux (Debian, Ubuntu, Mint)**
```bash
sudo apt update
sudo apt install -y vim curl git
```

**MacOSx** _(don't forget to install [Homebrew](https://brew.sh/) if you don't have one)_
```bash
brew install vim
```

1. Clone this repository on your Desktop folder.
1. Run the following commands to setup.

```sh
# Download Package Manager for plugins
curl -fsLo $HOME/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

cp -r ./dotfiles-master/vim/* ~/.vim/
ln -sf ~/Desktop/dotfiles/vim/vimrc ~/.vimrc
# now open "~/.vim/vimrc" file and run :PlugInstall and then :q
# sudo vim +PlugInstall +qall
```

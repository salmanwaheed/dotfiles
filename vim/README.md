# vim

* install plugins `sudo curl -fsLo $HOME/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim`
* clone repo
* go into the directory `cd dotfiles`
* install required packages `sudo apt update && sudo apt install -y vim git zsh`
* copy files `cp -r ./vim/* $HOME/.vim/`
* change onwership if its denied `sudo chown -R $USER:$USER $HOME/.vim`
* to install plugins `sudo vim +PlugInstall +qall`

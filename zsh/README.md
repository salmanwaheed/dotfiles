# zsh

* install zsh `sudo apt update && sudo apt install -y zsh`
* install ohmyzsh `sudo sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"`
* install dracula theme for zsh `https://draculatheme.com/zsh`
* install autocomplete
  * full details are here: `https://gist.github.com/dogrocker/1efb8fd9427779c827058f873b94df95`
  * `git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH/custom/plugins/zsh-autosuggestions`
  * `git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH/custom/plugins/zsh-syntax-highlighting`
* clone repo
* go into the directory `cd dotfiles`
* copy files `sudo cp -r ./zsh/.zshrc $HOME/.zshrc`
* restart your terminal
* set zsh as default terminal `chsh -s $(which zsh)`

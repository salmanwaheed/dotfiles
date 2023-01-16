# zsh

**Linux (Debian, Ubuntu, Mint)**
```bash
sudo apt install -y zsh
```

**MacOSx** _(don't forget to install [Homebrew](https://brew.sh/) if you don't have one)_
```bash
brew install zsh
```

1. Install dracula theme for zsh `https://draculatheme.com/zsh`.
1. Clone this repository on your Desktop folder.
1. Run the following commands to setup.

```sh
# Install oh-my-zsh package
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Install autocomplete.
# Full details are here: https://gist.github.com/dogrocker/1efb8fd9427779c827058f873b94df95
git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH/custom/plugins/zsh-syntax-highlighting


# option 1
sudo cp -r ~/Desktop/dotfiles/zsh/.zshrc ~/.zshrc

# option 2
ln -sf ~/Desktop/dotfiles/zsh/.zshrc ~/.zshrc

# Set zsh as your default terminal
chsh -s $(which zsh)
```

Don't forget to restart your terminal.

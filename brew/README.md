# brew

- don't forget to install [Homebrew](https://brew.sh/) if you don't have one
- if you get ownership issue (optional) `sudo chown -R $USER /usr/local/`
- clone current repo
- to install `brew bundle install`
- run `brew bundle dump` to generate `Brewfile` where all brew packages is listed

### pinentry-mac
```sh
echo "pinentry-program /usr/local/bin/pinentry-mac" >> ~/.gnupg/gpg-agent.conf
# chown -R $(whoami) ~/.gnupg/
# chmod 600 ~/.gnupg/*
# chmod 700 ~/.gnupg
```

### generating a gpg key
_Note: When asked to enter your email address, ensure that you enter the verified email address for your GitHub account._

```sh
gpg --expert --full-generate-key # generate a new gpg
gpg --list-secret-keys --keyid-format LONG # list secret keys
# Above command should return like this
# -------------------------------
# sec   4096R/<COPY_LONG_KEY> 2021-03-27 [expires: 2023-03-27]
# uid                          User Name <user.name@email.com>
# ssb   4096R/62E5B29EEA7145E 2021-03-27
gpg --armor --export <PASTE_LONG_KEY_HERE> > gpg-key.txt

# Above command will create a new txt file gpg-key.txt
# Add this key to GitHub
# Login to Github and goto profile settings (https://github.com/settings/keys)
# Click New GPG Key and paste the contents of gpg-key.txt file then save
# Tell (https://docs.github.com/en/github/authenticating-to-github/telling-git-about-your-signing-key) git client to auto sign your future commits

# Use the long key from above in next command
git config --global user.signingkey <PASTE_LONG_KEY_HERE> # setting key for git
git config --global commit.gpgsign true # setting key for git
# git config --global gpg.program gpg # setting key for git - optional

# if gpg-agent does not work properly then run following commands
sudo killall gpg-agent
gpg-agent --daemon
```

_You are done, next time when you commit changes; gpg will ask you the passphrase._

### create your own brew package
```sh
brew create URL # to create package
brew edit NewFormula # to edit package
brew install NewFormula # to install package
brew install --debug --verbose NewFormula # to debug/test package
brew uninstall NewFormula # to uninstall package
brew --prefix NewFormula # check the package location or path

# Create a new git branch for your formula so your pull request
# is easy to modify if any changes come up during review.
git checkout -b <new-branch-name>
git add Formula/<NewFormula>.rb
git commit
git push

# Homebrew Permissions Denied Issues Solution
sudo chown -R $(whoami) $(brew --prefix)/*
```

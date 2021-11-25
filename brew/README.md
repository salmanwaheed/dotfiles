# brew

Don't forget to install [Homebrew](https://brew.sh/) if you don't have one.

1. Clone this repository on your Desktop folder.
1. Run the following commands to setup.

```sh
# To install
brew bundle install
```

## Generating a GPG key
When asked to enter your email address, ensure that you enter the verified email address for your GitHub account.

```sh
# pinentry-mac
echo "pinentry-program /usr/local/bin/pinentry-mac" >> ~/.gnupg/gpg-agent.conf

# change permission
chmod 600 ~/.gnupg/*
chmod 700 ~/.gnupg

# optional - if you you don't own gnupg
chown -R $(whoami) ~/.gnupg/

# to generate a new gpg
gpg2 --expert --full-generate-key

# to list down all secret keys
gpg2 --list-secret-keys --keyid-format LONG
# Above command should return like this
# -------------------------------
# sec   4096R/<COPY_SECRET_KEY> 2021-03-27 [expires: 2023-03-27]
# uid                          User Name <email@domain.com>
# ssb   4096R/62E5B29EEA7145E 2021-03-27

# export public key to future use
gpg2 --armor --export PASTE_SECRET_KEY > gpg-key.txt

# Above command will create a new txt file gpg-key.txt
# Add this key to GitHub
# Login to Github and goto profile settings (https://github.com/settings/keys)
# Click New GPG Key and paste the contents of gpg-key.txt file then save
# Tell (https://docs.github.com/en/github/authenticating-to-github/telling-git-about-your-signing-key) git client to auto sign your future commits

# Use the long key from above in next command
git config --global user.signingkey PASTE_LONG_KEY_HERE # setting key for git
git config --global commit.gpgsign true # setting key for git
# git config --global gpg.program gpg # setting key for git - optional

# export private key to future use
gpg2 --export-secret-keys PASTE_SECRET_KEY > private.key

# import keys via private.key
gpg2 --import private.key

# delete unused keys
gpg2 --delete-secret-key PASTE_SECRET_KEY
gpg2 --delete-key PASTE_SECRET_KEY

# restart if you find any issue with gpg configurations
gpgconf --kill all

# if gpg-agent does not work properly then run following commands
sudo killall gpg-agent
gpg-agent --daemon

# optional
# If you get ownership issue,
# then run the following command to fix it.
sudo chown -R $USER /usr/local/

# To generate Brewfile where all brew packages is listed
brew bundle dump
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

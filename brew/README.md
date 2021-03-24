# brew

- don't forget to install [Homebrew](https://brew.sh/) if you don't have one
- if you get ownership issue (optional) `sudo chown -R $USER /usr/local/`
- clone repo
- to install `brew bundle install`
- to create `Brewfile` then run `brew bundle dump`

### pinentry-mac
```sh
echo "pinentry-program /usr/local/bin/pinentry-mac" >> ~/.gnupg/gpg-agent.conf
# chown -R $(whoami) ~/.gnupg/
# chmod 600 ~/.gnupg/*
# chmod 700 ~/.gnupg

git config --global commit.gpgsign true
```

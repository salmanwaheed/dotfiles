# Terminal Beauty

* tools:
  * `vim`, `git` & `zsh` will be automatically installed if not pre-installed.
* zsh & oh-my-zsh:
  * Theme: `dracula`
  * Plugins: git, zsh-autosuggestions, zsh-syntax-highlighting

**Install**

* You must install this package first
  * https://github.com/salmanwaheed/bash-lib

```bash
# after installed bash-lib you can run these command

# install zsh
bash-lib ins_pkg zsh

# Install oh-my-zsh mandatory
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# beauty terminal config
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/salmanwaheed/terminal-beauty/master/install.sh)"
```

**Uninstall**

```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/salmanwaheed/terminal-beauty/master/uninstall.sh)"
```

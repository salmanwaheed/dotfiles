#!/bin/bash

if ! [[ -f "/etc/sudoers.d/$USER" ]]; then
  echo "$USER ALL=(ALL:ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/$USER
fi

if ! [[ -d "$HOME/.ssh" ]]; then
  ssh-keygen -t rsa -b 4096 -C `hostname` -f "$HOME/.ssh/id_rsa" -q -P "" <<<y 2>&1 >/dev/null
  # eval "$(ssh-agent -s)"
  # ssh-add ~/.ssh/id_rsa
  # cat ~/.ssh/id_rsa.pub
  # Github.com > Profile > Settings > SSH and GPG keys > Add SSH key
  # 
  # git config --global user.email "you@example.com"
  # git config --global user.name "Your Name"
fi

sudo apt update
sudo apt install -y \
  apt-transport-https \
  ca-certificates \
  git \
  curl \
  vim \
  zsh \
  awscli \
  ansible \
  openjdk-8-jdk

if ! [[ `which docker` ]]; then
  sudo apt install -y docker.io docker-compose
  sudo usermod -aG docker $USER
  sudo chown $USER:docker /var/run/docker.sock
  sudo chmod 666 /var/run/docker.sock
fi

if ! [[ `which terraform` ]]; then
  curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
  sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
  sudo apt update
  sudo apt install -y terraform
fi

if ! [[ `which kubectl` ]]; then
  sudo curl -fsSLo \
    /usr/share/keyrings/kubernetes-archive-keyring.gpg \
    https://packages.cloud.google.com/apt/doc/apt-key.gpg
  echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
  sudo apt update
  sudo apt install -y kubectl
fi

if ! [[ `which code` ]]; then
  wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
  sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
  sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
  rm -f packages.microsoft.gpg

  sudo apt update
  sudo apt install code # or code-insiders
fi

if ! [[ `which mysql` ]]; then
  sudo apt install -y mysql-server

  # sudo mysql_secure_installation
  # OR, use the following commands to configure mysql
  # sudo mysql
  #
  # SELECT user,authentication_string,plugin,host FROM mysql.user;
  # ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'password';
  # FLUSH PRIVILEGES;
  #
  # CREATE USER 'salman'@'localhost' IDENTIFIED BY 'password';
  # GRANT ALL PRIVILEGES ON *.* TO 'salman'@'localhost' WITH GRANT OPTION;
  # 
  # exit
  #
  # sudo systemctl status mysql.service
  # sudo mysqladmin -u root version
fi

if ! [[ `google-chrome` ]]; then
  wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
  sudo apt install ./google-chrome-stable_current_amd64.deb
  sudo rm -rf ./google-chrome-stable_current_amd64.deb
fi

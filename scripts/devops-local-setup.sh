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

if ! [[ `which google-chrome` ]]; then
  wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
  sudo apt install -y ./google-chrome-stable_current_amd64.deb
  sudo rm -rf ./google-chrome-stable_current_amd64.deb
fi

if ! [[ `which openvpn` ]]; then
  # version 2.0
  sudo apt-get install openvpn
  # https://99.80.209.238:943/admin/
  # https://99.80.209.238:943/?src=connect
  # click on Yourself (autologin profile) button
  # and download client.ovpn file
  # and run the folowing command
  # sudo openvpn --config /path/to/client.ovpn --auth-nocache --daemon

  # version 3.0
  # https://openvpn.net/cloud-docs/openvpn-3-client-for-linux/
  # curl -fsSL https://swupdate.openvpn.net/repos/openvpn-repo-pkg-key.pub | sudo apt-key add -
  # echo "deb [arch=amd64] https://swupdate.openvpn.net/community/openvpn3/repos $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/openvpn3.list
  # sudo apt update
  # sudo apt install openvpn3
fi

if ! [[ `which zoom` ]]; then
  wget https://zoom.us/client/latest/zoom_amd64.deb
  sudo apt install -y ./zoom_amd64.deb
  sudo rm -rf ./zoom_amd64.deb
  # sudo apt remove zoom
fi

if ! [[ `which dbeaver` ]]; then
  wget https://dbeaver.io/files/dbeaver-ce_latest_amd64.deb
  sudo apt install -y ./dbeaver-ce_latest_amd64.deb
  sudo rm -rf ./dbeaver-ce_latest_amd64.deb
  # sudo apt remove dbeaver
fi

if ! [[ `which go` ]]; then
  wget -c https://dl.google.com/go/go1.14.2.linux-amd64.tar.gz -O - | sudo tar -xz -C /usr/local
  export PATH=$PATH:/usr/local/go/bin
  # restart terminal before running the following command
  go version
fi

if ! [[ `which aws` ]]; then
  cd ~/Desktop
  curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
  unzip ./awscliv2.zip
  sudo ./aws/install -i /usr/local/aws-cli -b /usr/local/bin
  rm -f ./awscliv2.zip ./aws

  # aws configure sso
  # SSO start URL [None]: https://yallacompare.awsapps.com/start
  # SSO Region [None]: eu-west-1
  # CLI profile name [YOUR_ROLE-ACCOUNT_NUMBER]: default
fi

mkdir robo3t
wget -q https://github.com/Studio3T/robomongo/releases/download/v1.4.4/robo3t-1.4.4-linux-x86_64-e6ac9ec.tar.gz -P ./robo3t
tar -xzf ./robo3t/robo3t-1.4.4-linux-x86_64-e6ac9ec.tar.gz -C ./robo3t --strip-components=1
./studio-3t-linux-x64.sh

sudo snap install robo3t-snap

# https://www.linode.com/docs/guides/install-and-configure-redis-on-centos-7/

mkdir redis-server
wget -q https://download.redis.io/releases/redis-3.2.8.tar.gz -P ./redis-server
tar -xzf ./redis-server/redis-3.2.8.tar.gz -C ./redis-server --strip-components=1
cd redis-server
make


sudo yum install epel-release
sudo yum update
sudo yum install redis
sudo systemctl start redis
sudo systemctl enable redis



sudo yum install -y amazon-linux-extras
sudo amazon-linux-extras install java-openjdk11
sudo yum install java-1.8.0-openjdk
sudo yum install java-1.8.0-openjdk-devel
sudo amazon-linux-extras install redis6

redis-server 0.0.0.0:6379
redis-server --port 6379 --replicaof 0.0.0.0 6379



sudo add-apt-repository ppa:tomtomtom/woeusb
sudo apt install woeusb woeusb-frontend-wxgtk
sudo add-apt-repository --remove ppa:tomtomtom/woeusb





sudo yum update -y
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
sudo yum upgrade
sudo amazon-linux-extras install java-openjdk11 -y
sudo yum install jenkins -y
sudo systemctl enable jenkins
sudo systemctl start jenkins
sudo systemctl status jenkins


#!/bin/bash

# uninstall
# sudo systemctl stop tomcat \
#   && sudo unlink /etc/systemd/system/tomcat.service \
#   && sudo systemctl daemon-reload \
#   && sudo rm -rf /opt

PROJECT_NAME=tomcat
MAIN_DIR=/opt
TOMCAT_DIR=$MAIN_DIR/$PROJECT_NAME
TOMCAT_VERSION=8.5.77
TOMCAT_PACKAGE=apache-tomcat-$TOMCAT_VERSION.tar.gz
TOMCAT_PACKAGE_PATH=$MAIN_DIR/$TOMCAT_PACKAGE
PLATFORM=$(cat /etc/os-release | grep ^ID= | awk -F '"' '{print $2}')

if [[ $PLATFORM == "centos" ]]; then
  # for CentOS
  JAVAC_PATH=/usr/lib/jvm/java-11-openjdk-11.0.14.1.1-1.el7_9.x86_64
  # sudo yum update -y
  # sudo amazon-linux-extras install -y java-openjdk11
  # sudo yum install -y java-11-openjdk java-11-openjdk-devel wget
  # sudo yum install java-1.8.0-openjdk java-1.8.0-openjdk-devel
  # sudo yum install tomcat-native
  # sudo apt install libtcnative-1

  # sudo yum update --security -y
  # sudo yum autoremove
  # sudo yum clean all

  # sudo yum install -y glibc-langpack-en
  # package-cleanup --dupes
else
  # for debian
  JAVAC_PATH=$(readlink -f /usr/bin/javac | sed "s:/bin/javac::")
  # sudo apt update
  # sudo apt install -y default-jdk
fi

# if ! [[ `which java` ]]; then
#   echo "Installing Java...." \
#     && sudo apt update -qq \
#     && sudo apt install -y default-jdk
# else
#   echo "-- $JAVAC_PATH is already installed!"
# fi

if ! [[ -d "$MAIN_DIR" ]]; then
  sudo mkdir -p $MAIN_DIR \
  	&& echo "-- $MAIN_DIR is created!"
  # cd $MAIN_DIR
else
  echo "-- $MAIN_DIR directory is found! Using it..."
fi

if ! [[ -f "$TOMCAT_PACKAGE_PATH" ]] && ! [[ -d "$TOMCAT_DIR" ]]; then
  # sudo wget -q https://dlcdn.apache.org/tomcat/tomcat-8/v8.5.78/bin/apache-tomcat-8.5.78.tar.gz -P ~/tomcat
  echo "-- Downloading $TOMCAT_PACKAGE_PATH ...." \
    && sudo wget -q https://dlcdn.apache.org/tomcat/tomcat-8/v$TOMCAT_VERSION/bin/$TOMCAT_PACKAGE -P $MAIN_DIR \
    && echo "--- Downloaded!"
else
  echo "-- $TOMCAT_PACKAGE_PATH is found! Using it..."
fi

if [[ -f "$TOMCAT_PACKAGE_PATH" ]]; then
  echo "-- Transferring all files to $TOMCAT_DIR directory..." \
    && sudo mkdir -p $TOMCAT_DIR \
    && sudo tar -zxf $TOMCAT_PACKAGE_PATH -C $TOMCAT_DIR --strip-components=1 \
    && sudo chown -R $USER:$USER $MAIN_DIR \
    && echo "--- Transferred!"
    # && mv $MAIN_DIR/apache-tomcat-$TOMCAT_VERSION $TOMCAT_DIR \
    # cd $TOMCAT_DIR
else
  echo "-- $TOMCAT_DIR directory is found! Using it..."
fi

if [[ -f "$TOMCAT_PACKAGE_PATH" ]]; then
  sudo rm -rf $TOMCAT_PACKAGE_PATH \
	  && echo "-- Removed $TOMCAT_PACKAGE_PATH file!"
fi

if ! [[ -f "$TOMCAT_DIR/$PROJECT_NAME.service" ]]; then
sudo cat <<EOF > $TOMCAT_DIR/$PROJECT_NAME.service
[Unit]
Description=Apache Tomcat $TOMCAT_VERSION Server
After=network.target

[Service]
Type=forking

User=$USER
Group=$USER

Environment="JAVA_HOME=$JAVAC_PATH"
Environment="JAVA_OPTS=-Djava.security.egd=file:///dev/urandom -Djava.awt.headless=true"

Environment="CATALINA_BASE=$TOMCAT_DIR"
Environment="CATALINA_HOME=$TOMCAT_DIR"
Environment="CATALINA_PID=$TOMCAT_DIR/temp/$PROJECT_NAME.pid"
Environment="CATALINA_OPTS=-Xms512M -Xmx1024M -server -XX:+UseParallelGC -XX:+HeapDumpOnOutOfMemoryError"

ExecStart=$TOMCAT_DIR/bin/startup.sh
ExecStop=$TOMCAT_DIR/bin/shutdown.sh

[Install]
WantedBy=multi-user.target
EOF
  echo "-- $PROJECT_NAME.service has created!" \
    && sudo ln -sf $TOMCAT_DIR/$PROJECT_NAME.service /etc/systemd/system/$PROJECT_NAME.service \
    && sudo systemctl daemon-reload \
    && sudo systemctl enable $PROJECT_NAME \
    && sudo systemctl start $PROJECT_NAME \
    && echo "-- $PROJECT_NAME.service is linked to systemctl command!"
else
  echo "-- $PROJECT_NAME.service is already linked to systemctl command. Using it..."
fi

# if ! [[ -d "$TOMCAT_DIR/webapps/{docs,examples,*manager}" ]]; then
#   echo "-- We don't need these directories"
#   sudo rm -vrf $TOMCAT_DIR/webapps/{docs,examples,*manager}
# fi

# sudo sh -c 'chmod +x $TOMCAT_DIR/bin/*.sh'

# readlink -f /usr/bin/javac | sed "s:/bin/javac::"
# export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
# export CATALINA_HOME=$TOMCAT_DIR

# tail -f $TOMCAT_DIR/logs/catalina.out
# sudo vim $TOMCAT_DIR/latest/conf/tomcat-users.xml

#!/bin/bash
#
# Bikash Sen [Consultant]
#
# Hyperledger Fabric v1.0
# Free License: Tested on Ubuntu 16.04
#
# Ref: https://github.com/hyperledger/fabric/blob/master/docs/source/getting_started.rst
# Ref: http://hyperledger-fabric.readthedocs.io/en/latest/configtxgen.html
# Ref: https://github.com/hyperledger/fabric/blob/master/examples/e2e_cli/end-to-end.rst

## login as root to run docker commands. Login as root manually.
#sudo su -
#cd /home/ubuntu
#vi myscript.sh
# Esc+:wq!+Enter
#chmod +x myscript.sh
#./myscript.sh

echo "######################################################################"
echo "############ Started installing prerequisite softwares ###############"
echo "######################################################################"

echo
echo "###################################################"
echo "######## Started installing Oracle Java8 ##########"
echo "###################################################"

## Install Oracle Java8 with auto accepted license aggreement
sudo add-apt-repository -y ppa:webupd8team/java
sudo apt-get update
echo debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections
echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections
sudo apt-get -y install oracle-java8-installer 

echo
echo "###################################################"
echo "############ Started installing Git ###############"
echo "###################################################"
echo

sudo apt-get install git -y

echo
echo "###################################################"
echo "########### Started installing Maven ##############"
echo "###################################################"
echo

sudo apt install maven -y

echo
echo "###################################################"
echo "####### Started installing JQ [JSON CLI] ##########"
echo "###################################################"
echo
## JSON editor, which we can use to manipulate JSON programatically. This is required for dynamically change configuration.
sudo apt-get install jq -y

echo
echo "###################################################"
echo "######## Started installing Tree utility ##########"
echo "###################################################"
echo
## Display/Print the directory structure in the form of a tree.
sudo apt install tree -y
#tree crypto-config

echo
echo "###################################################"
echo "######### Started installing Gradle 3.5 ###########"
echo "###################################################"
echo

## Gradle is required for Java chaincode development

sudo apt-get install unzip -y

wget https://services.gradle.org/distributions/gradle-3.5-bin.zip
if [ ! -d /opt/gradle ]; then
 sudo mkdir -p /opt/gradle
 sudo unzip -d /opt/gradle gradle-3.5-bin.zip
fi
export PATH=$PATH:/opt/gradle/gradle-3.5/bin

rm -f gradle-3.5-bin.zip

echo
echo "###################################################"
echo "###### Started installing latest Docker ###########"
echo "###################################################"
echo
## Install Docker CE(Community Edition)

## Add the GPG key for the official Docker repository to the system
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
apt-cache policy docker-ce
sudo apt-get install -y docker-ce

## Check that it's running:
#sudo systemctl status docker

## Install docker engine
sudo apt-get install -y docker-engine

## Install docker compose
apt install docker-compose -y

echo
echo "###################################################"
echo "###### Started installing latest GO language ######"
echo "###################################################"
echo
	
sudo add-apt-repository ppa:longsleep/golang-backports -y
sudo apt-get update
sudo apt-get install golang-go -y

#export GOPATH=/home/ubuntu
#export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

echo
echo "Listing all GO environment values..........."
go env

echo
echo "###################################################"
echo "######## Started installing make utility ##########"
echo "###################################################"
echo

## Make utility is helpfull to build executable binary from source code using 'Makefile'.
apt install make -y

## This installation is required to solve "fatal error: ltdl.h: no such file or directory". 
## https://jira.hyperledger.org/browse/FAB-2684. For more information on libtool, see https://www.gnu.org/software/libtool.
sudo apt install libtool libltdl-dev -y

echo
echo "###################################################"
echo "########## Started installing NodeJS 6.x ##########"
echo "###################################################"
	
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
sudo apt-get install -y nodejs -y

## Installing NPM(Node.js package manager)
sudo apt-get install npm -y
## Update latest or specific npm version
#sudo npm install npm@latest -g
sudo npm install npm@5.5.1 -g -y

## Install gulp. gulp is a build tool in JavaScript on Node.js. All Gulp configuration goes in 'gulpfile.js' in the root of your project.
## We will specify the gulp plugins we're about to use in 'package.json' in the root of your project.
sudo npm install -g gulp -y

echo
echo "Veriyfying all pre-requisite software versions............"
echo

echo "-----------------------------------------------------------"
echo "Java Version"
echo "-----------------------------------------------------------"
java -version

echo
echo "-----------------------------------------------------------"
echo "Git Version"
echo "-----------------------------------------------------------"
git --version
	
echo
echo "-----------------------------------------------------------"
echo "Maven Version"
echo "-----------------------------------------------------------"
mvn --version

echo
echo "-----------------------------------------------------------"
echo "Gradle Version"
echo "-----------------------------------------------------------"
gradle -v

echo
echo "-----------------------------------------------------------"
echo "Docker Engine Version"
echo "-----------------------------------------------------------"
docker version

echo
echo "-----------------------------------------------------------"
echo "Docker Compose Version"
echo "-----------------------------------------------------------"
docker-compose --version

echo
echo "-----------------------------------------------------------"
echo "GO Language Version"
echo "-----------------------------------------------------------"
go version

echo
echo "-----------------------------------------------------------"
echo "NodeJS & NPM Version"
echo "-----------------------------------------------------------"
node -v
npm -v

echo
echo "######################################################################"
echo "###################### Installation Done #############################"
echo "######################################################################"
echo
echo "######################################################################"
echo "################### Started clean-up process #########################"
echo "######################################################################"
echo

# Remove all containers regardless of state
echo "Removing all docker containers....."
docker rm -vf $(docker ps -a -q) 2>/dev/null || echo "No more containers to remove."

echo "Removing all docker images....."
# Remove all docker images
docker rmi -f $(docker images -a -q) 2>/dev/null || echo "No more images to remove."

# Remove release folder from current directory if exists
if [ -d "release" ]; then
 rm -r release 
fi

# Remove existing 'fabric' folder from current directory if exists
if [ -d "fabric" ]; then
 rm -r fabric 
fi

echo
echo "######################################################################"
echo "################### Ended clean-up process ###########################"
echo "######################################################################"

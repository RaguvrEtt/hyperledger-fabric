# hyperledger-fabric
Fabric Gits

#Installation of Fabric Pre-requisites

Fabric-pre.sh

#cURL should be installed on your machine by default.
#To check, run the following command in your terminal/command line:

$ curl -V

Note: The "V" is capitalized.

#Visit https://nodejs.org/en/download/ for details about installing or updating Node.js and npm for MacOS.

#Verify the installation,  as well as the versions of both Node.js and npm, and make sure the Node.js version you are installing is greater than v6.9 (do not use v7), and the npm version is greater than 3.x:

$ node --version && npm --version

#Visit https://golang.org/dl/ and make note of the latest stable release (v1.8 or later):

$ cd ~

$ sudo curl -O https://storage.googleapis.com/golang/go1.9.2.darwin-amd64.pkg

#Note: Switch out the black portion of the URL with the correct filename.

#Open the downloaded file to run the installation package:

$ open go1.9.2.darwin-amd64.pkg

#After completing the installation, go will have been installed at /usr/local/bin/go. You can check by running:

$ which go

##Now, we will need to add environment variables to make sure that the source code is located within the $GOPATH. You will need to have a single workplace for all your Go projects.

##First, you will need to check that you have set your $GOPATH environment variable:

$ echo $GOPATH

And you should get the following response:

/Users/xxx/go

If there is no response, you will tell Go the location of our chosen workspace, by modifying the .profile file located in your home directory:

$ nano ~/.profile

Note: If you want, you can use vim or vi to edit this file, instead of nano.

Within this file, add the following two lines, to export the required variables:

$ export GOPATH=$HOME/go

$ export PATH=$PATH:$GOPATH/bin

Note: To save in nano, press Control + O and then, press Enter.

Note: To exit and navigate back to clear shell, press Control + x.

Rerun .profile to run these new paths:

$ source .profile

Check that the Go version is v1.8 or later:

$ go version

To download Docker, you are required to have OSX Yosemite 10.10.3, or above. Otherwise, for previous OS versions, you should download Docker Toolbox.

Note: Installing Docker for Mac or Docker Toolbox will also install Docker Compose. If you already have Docker installed, you should check that you have Docker Compose version 1.9.0 or greater installed. If not, we recommend that you install a more recent version of Docker.

This VM will host the Hyperledger Fabric peers and other network nodes.

Visit https://www.docker.com/docker-mac and click "Download from Docker Store".

Check to make sure that you have version 17.03.1-ce or greater:

$ docker --version && docker-compose --version


Next, we will download the latest released Docker images for Hyperledger Fabric, and tag them with the latest tag. Execute the command from within the directory into which you will extract the platform-specific binaries:

$ curl -sSL https://goo.gl/Q3YRTi | bash

Note: Check https://hyperledger-fabric.readthedocs.io/en/latest/samples.html#binaries for the latest URL (the blue portion in the above curl command) to pull in binaries.

This command downloads binaries for cryptogen, configtxgen, configxlator, peer AND downloads the Hyperledger Fabric Docker images. These assets are placed in a bin subdirectory of the current working directory.

To confirm and see the list of Docker images you’ve just downloaded, run:

$ docker images


Note the tags for each of the repositories above boxed in red. If the Docker images are not already tagged with the latest tag, perform the following command for each of the Docker images:

$ docker tag hyperledger/fabric-tools:x86_64-1.0.2 hyperledger/fabric-tools:latest

Swap out the blue portion with the tags you see in your list of repositories. Also, swap out the red portion with the name of the Docker image you are switching the tag for (e.g.: fabric-tools, fabric-ccenv, fabric-orderer, etc.). Repeat this step for all Docker images you see in the list.

In the screenshot above, the Docker images are already tagged. If this is the case for you, you do not need to do this extra step.


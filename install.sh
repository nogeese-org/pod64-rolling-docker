#!/bin/bash

SOURCEPOD64=$(pwd)

cd $SOURCEPOD64/build/essential/script.sh.d/
echo "export arch=pod64-docker" | sudo tee -a /etc/environment
export arch=pod64-docker
cd /etc
{
    echo ""
    echo "[bit]"
    echo "Server = https://raw.githubusercontent.com/nogeese-org/mirror/stable/bit/os/pod64-docker"
    echo "SigLevel = Optional TrustAll"
} | sudo tee -a pacman.conf
{
    echo ""
    echo "[nogeese]"
    echo "Server = https://raw.githubusercontent.com/nogeese-org/mirror/main/bit/os/pod64-docker"
    echo "SigLevel = Optional TrustAll"
} | sudo tee -a pacman.conf
cd $SOURCEPOD64/build
mkdir appsrc
cd appsrc
curl -sSL https://raw.githubusercontent.com/nogeese-org/InfoKit/main/installer/install.sh | sudo bash
cd ../sys
git clone https://github.com/nogeese-org/rolling.git ./master
cd master
bash architectures/pod64-docker.sh
bash scripts/appsetup.sh
cd ../../appsrc
git clone https://github.com/nogeese-org/podutils-docker.git ./podutils
cd podutils
bash scripts/flush.sh
rm -rf /etc/os-release
curl https://nogeese-org.github.io/pod64-rolling-docker/os-release -o /etc/os-release
clear
echo "This message was automaticly sent."
echo "The system is ready to use."
exit 0

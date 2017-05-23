#!/bin/bash

#check whether the user is on a debian or redhat distro

YUM_CMD=$(which yum)
APT_GET_CMD=$(which apt-get)

echo "installing dependencies"

#if on redhat use yum
if [[! -z $YUM_CMD]]; then
	yum -y install epel-release
	yum -y groupinstall "Development Tools"
	yum -y install kernel-devel
	yum -y install git

#if debian use apt-get
elif [[! -z $APT_GET_CMD=$(which apt-get)]]; then
	apt-get -y install epel-release
	apt-get -y groupinstall "Development Tools"
	apt-get -y install kernel-devel
	apt-get -y install git
fi

#get source code

echo "cloning source code for Xi-cam"

cd ~
git clone https://github.com/ronpandolfi/Xi-cam.git

#setup python
echo "setting up python"
wget https://repo.continuum.io/archive/Anaconda2-4.3.1-Linux-x86_64.sh
bash Anaconda2-4.3.1-Linux-x86_64.sh

#after running, delete installer
rm Anaconda2-4.3.1-Linux-x86_64.sh

#modify PATH variable
export PATH=~/anaconda2/bin:$path

#make sure pip is working
conda -y install pip

#install python dependencies
echo "installing python dependencies"
pip -y install numpy scipy
pip -y install pyFai paramiko
conda -y install pyside
conda -y install dgursoy tomopy

#install additional libraries
echo "installing additional libraries"

if [[! -z $YUM_CMD]]; then
	yum -y install cmake
	yum -y install qt4-devel
	yum -y install qt4-webkit-devel
	yum -y install libxml2-devel libxslt-devel
elif [[! -z $APT_GET_CMD=$(which apt-get)]]; then
	apt-get -y install cmake
	apt-get -y install qt4-devel
	apt-get -y install qt4-webkit-devel
	apt-get -y install libxml2-devel libxslt-devel
fi

#run Xi-cam setup
echo "running Xi-cam setup"
cd Xi-cam
python setup.py build
python setup.py install




	



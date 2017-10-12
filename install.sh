#!/bin/bash
# This is scripts install NGINX for Directadmin.
### Build by Websanco ###
RED='\033[01;31m'
GREEN='\033[01;32m'
RESET='\033[0m'

#Clear Screen For Install
clear

cho -e "$GREEN----------------------------------------$RESET"
echo -e "  $RED NGINX for Directadmin. $RESET"
echo -e "           Version Release: 1.0          "
echo -e "     Build by websanco  "
echo -e "$GREEN----------------------------------------$RESET"

yum install wget gcc gcc-c++ flex bison make bind bind-libs bind-utils openssl openssl-devel perl quota libaio libcom_err-devel libcurl-devel gd zlib-devel zip unzip libcap-devel cronie bzip2 cyrus-sasl-devel perl-ExtUtils-Embed autoconf automake libtool which patch mailx db4-devel  
wget http://www.directadmin.com/setup.sh  
chmod 755 setup.sh  
./setup.sh


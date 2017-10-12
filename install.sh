#!/bin/bash
yum install wget gcc gcc-c++ flex bison make bind bind-libs bind-utils openssl openssl-devel perl quota libaio libcom_err-devel libcurl-devel gd zlib-devel zip unzip libcap-devel cronie bzip2 cyrus-sasl-devel perl-ExtUtils-Embed autoconf automake libtool which patch mailx db4-devel  
wget http://www.directadmin.com/setup.sh  
chmod 755 setup.sh  
./setup.sh


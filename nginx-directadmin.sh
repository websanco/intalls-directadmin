#!/bin/bash

#intall
##yum install perl-libwww-perl
#//cd /usr/src/
#//wget https://download.configserver.com/csf.tgz
#tar -xzf csf.tgz
#cd csf
#sh install.sh
#cd /usr/local/csf/bin/
#perl csftest.pl
wget http://files.directadmin.com/services/all/csf/csf_install.sh  
/bin/sh ./csf_install.sh 
chkconfig --level 235 csf on  
#echo "exe:/bin/tar" >> /etc/csf/csf.pignore
systemctl start csf
systemctl start lfd

echo "letsencrypt=1" >> /usr/local/directadmin/conf/directadmin.conf  
echo "enable_ssl_sni=1" >> /usr/local/directadmin/conf/directadmin.conf
echo "check_subdomain_owner=0" >> /usr/local/directadmin/conf/directadmin.conf  
echo "hide_ip_user_numbers=0" >> /usr/local/directadmin/conf/directadmin.conf 
/etc/init.d/directadmin restart  
wget -O /usr/local/directadmin/scripts/letsencrypt.sh http://files.directadmin.com/services/all/letsencrypt.sh  
cd /usr/local/directadmin/custombuild  
./build update  
./build letsencrypt  
./build rewrite_confs

cd /usr/local/directadmin/custombuild
./build update
./build set php1_release 5.6
./build set php2_release 5.4
./build set php1_mode php-fpm
./build set php2_mode php-fpm
./build set mod_ruid2 no
./build php n
./build rewrite_confs

cd /usr/local/directadmin/custombuild
./build set opcache yes
./build opcache
cd /usr/local/directadmin/custombuild
./build update
./build update_da
./build set webserver nginx_apache
./build nginx_apache
./build rewrite_confs
echo "action=rewrite&value=nginx" >> /usr/local/directadmin/data/task.queue  
echo "action=rewrite&value=nginx" >> /usr/local/directadmin/dataskq

#service httpd restart
#service nginx restart
systemctl start httpd
sudo systemctl start nginx


cd /usr/local/directadmin
echo "action=directadmin&value=restart" >> data/task.queue; ./dataskq d2000

cd /usr/local/directadmin/custombuild
./build update
./build clean
./build suphp
./build roundcube
./build squirrelmail
./build phpmyadmin
./build rewrite_confs

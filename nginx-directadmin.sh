#!/bin/bash

#intall
yum install perl-libwww-perl
cd /tmp
wget https://download.configserver.com/csf.tgz
tar -xzf csf.tgz
cd csf
sh install.sh
chkconfig --level 235 csf on  
service csf restart


sudo systemctl start firewalld.service
sudo firewall-cmd --zone=public --add-port=2222/tcp
sudo firewall-cmd --zone=public --add-port=80/tcp
sudo firewall-cmd --zone=public --add-port=21/tcp
sudo firewall-cmd --zone=public --add-port=8080/tcp
sudo firewall-cmd --zone=public --add-port=25/tcp
sudo firewall-cmd --zone=public --add-port=465/tcp
sudo firewall-cmd --zone=public --add-port=587/tcp
sudo firewall-cmd --reload



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
./build set php1_release 7.0
./build set php2_release 5.4
./build set php1_mode php-fpm
./build set php2_mode php-fpm
./build set mod_ruid2 no
./build php n
./build rewrite_confs
cd /usr/local/directadmin/custombuild
./build update
./build clean
./build suphp
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
service httpd restart
service nginx restart
cd /usr/local/directadmin
echo "action=directadmin&value=restart" >> data/task.queue; ./dataskq d2000
cd /usr/local/directadmin/custombuild
./build roundcube
./build squirrelmail
./build phpmyadmin
./build rewrite_confs

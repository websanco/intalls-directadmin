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

/sbin/iptables -I INPUT 1 -p tcp --dport 2222 -j ACCEPT  
/sbin/iptables -I INPUT 1 -p tcp --dport 80 -j ACCEPT  
/sbin/iptables -I INPUT 1 -p tcp --dport 21 -j ACCEPT  
/sbin/iptables -I INPUT 1 -p tcp --dport 8080 -j ACCEPT
/sbin/iptables -I INPUT 1 -p tcp --dport 25 -j ACCEPT 
/sbin/iptables -I INPUT 1 -p tcp --dport 465 -j ACCEPT
/sbin/iptables -I INPUT 1 -p tcp --dport 587 -j ACCEPT  
service iptables save  
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

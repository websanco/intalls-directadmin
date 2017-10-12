#!/bin/bash
# This file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output.  So make sure this doesn't display
# anything or bad things will happen !


# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.



wget http://files.directadmin.com/services/all/csf/csf_install.sh  
/bin/sh ./csf_install.sh
chkconfig --level 235 csf on  
service csf restart
/sbin/iptables -I INPUT 1 -p tcp --dport 2222 -j ACCEPT  
/sbin/iptables -I INPUT 1 -p tcp --dport 80 -j ACCEPT  
/sbin/iptables -I INPUT 1 -p tcp --dport 21 -j ACCEPT  
/sbin/iptables -I INPUT 1 -p tcp --dport 8080 -j ACCEPT  
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
./build set php1_release 5.6
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
./build roundcube
./build squirrelmail
./build phpmyadmin
cd /usr/local/directadmin/custombuild
./build set opcache yes
./build opcache
echo "action=rewrite&value=nginx" >> /usr/local/directadmin/data/task.queue  
echo "action=rewrite&value=nginx" >> /usr/local/directadmin/dataskq
service httpd restart
service nginx restart
cd /usr/local/directadmin
echo "action=directadmin&value=restart" >> data/task.queue; ./dataskq d2000
./build rewrite_confs
cd /usr/local/directadmin/custombuild
 


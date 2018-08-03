# Intalls directadmin CENTOST 7
systemctl disable firewalld  
systemctl stop firewalld  
yum install wget  
wget https://raw.githubusercontent.com/websanco/intalls-directadmin/master/install.sh -O install.sh  
chmod 755 install.sh  
./install.sh  



# Intalls  ALL A_Z  PHP5.6,5.4, NGINX CSF, LETSCRIPT
wget https://raw.githubusercontent.com/websanco/intalls-directadmin/master/nginx-directadmin.sh -O nginx-directadmin.sh    
chmod 755 nginx-directadmin.sh   
./nginx-directadmin.sh   

 
................................................................................................................

FIX DOWLOAD .ZP

vi /etc/mime.types


# application/x-font-vfont
 application/x-freearc arc
 application/x-futuresplash spl
 application/x-gca-compressed gca
 application/x-glulx ulx
 application/x-gnumeric gnumeric
 application/x-gramps-xml gramps
 application/x-gtar gtar
 application/x-gzip gz
 application/x-hdf hdf
 application/x-install-instructions install
 application/x-iso9660-image iso
 
 
systemctl status directadmin.service
systemctl restart directadmin.service
 
 or
 
 
cd /usr/local/directadmin
echo "action=directadmin&value=restart" >> data/task.queue; ./dataskq d2000



....................................................

ONLY INTALL TWO LINE DONATE:

GIFT
https://www.vultr.com/?ref=7224032
https://m.do.co/c/f579d3db6d69  

DONATE: http://paypal.me/OnlineServicesVN



sudo apt-get install p7zip-full p7zip-rar


# Intalls  ALL A_Z  PHP7+5.4 NGINX CSF, LETSCRIPT
wget https://github.com/websanco/intalls-directadmin/raw/master/php7-all.sh -O php7-all.sh   
chmod 755 php7-all.sh  
./php7-all.sh  


# Intalls CSF - OPENPORT  
wget https://raw.githubusercontent.com/websanco/intalls-directadmin/master/openport-cfs.sh -O openport-cfs.sh  
chmod 755 openport-cfs.sh  
./openport-cfs.sh  

# Intalls NGINX
wget https://raw.githubusercontent.com/websanco/intalls-directadmin/master/csf-to-nginx.sh -O csf-to-nginx.sh  
chmod 755 csf-to-nginx.sh  
./csf-to-nginx.sh

# Register HTTPS DOMAIN Let's Encrypt SSL For Port 2222
#Readmore: https://help.directadmin.com/item.php?id=629

# Enable CSF
nano /etc/csf/csf.conf


update https://help.directadmin.com/item.php?id=354



https://help.directadmin.com/item.php?id=641 (quản lý chung)

ALL https://help.directadmin.com/item.php?id=284

http://help.directadmin.com/item.php?id=354

apache_public_html = 0

echo “=1” >> /usr/local/directadmin/conf/directadmin.conf

cd /usr/local/directadmin
./directadmin c | grep ^apache_public_html=

service directadmin restart

 

lost_password = 0

 


hide_ip_user_numbers = 0
Nếu bạn muốn chia sẻ một địa chỉ IP trong số rất nhiều đại lý, ẩn số của người sử dụng trên IP.
http://www.directadmin.com/features.php?id=876

1. echo “check_subdomain_owner=1” >> /usr/local/directadmin/conf/directadmin.conf

2.echo “hide_ip_user_numbers=0” >> /usr/local/directadmin/conf/directadmin.conf

cd /usr/local/directadmin
./directadmin c | grep ^hide_ip_user_numbers=

cd /usr/local/directadmin
echo “action=directadmin&value=restart” >> data/task.queue; ./dataskq d2000

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




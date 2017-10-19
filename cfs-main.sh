#!/bin/sh
# CSF installed, based on:
# https://help.poralix.com/articles/how-to-block-ips-with-csf-directadmin-bfm

#VERSION=0.1

CSF_CONF=/etc/csf/csf.conf
DA_CONF=/usr/local/directadmin/conf/directadmin.conf
if [ ! -s ${DA_CONF} ]; then
	if [ -s /usr/local/directadmin/data/templates/directadmin.conf ]; then
		DA_CONF=/usr/local/directadmin/data/templates/directadmin.conf
		echo "DA is not yet installed. Will use $DA_CONF for settings."
	else
		echo "Cannot find conf/directadmin.conf, nor data/templates/directadmin.conf.  Please install DA first"
		exit 4
	fi
fi

cd /usr/local/src
wget -O csf.tgz https://download.configserver.com/csf.tgz

if [ ! -s csf.tgz ]; then
	echo "csf.tgz download failed."
	exit 1;
fi

tar -zxf csf.tgz
cd ./csf

PASS=`./csftest.pl | tail -n 1 | grep -c 'RESULT: csf should function on this server'`
if [ "${PASS}" != "1" ]; then
	./csftest.pl
	echo "";
	echo "";
	echo "CSF test did not pass. Will not continue";
	exit 2;
fi

echo "CSF test passed. Installing for DirectAdmin ...";

./install.directadmin.sh

if [ ! -s ${CSF_CONF} ]; then
	echo "Cannot find ${CSF_CONF}. Aborting.";
	exit 3;
fi

perl -pi -e 's/^TESTING = "1"/TESTING = "0"/' ${CSF_CONF}

#Encrypted FTPS requires these ports open
C=`grep ^TCP_IN ${CSF_CONF} | grep -c 3500`
if [ "$C" = "0" ]; then
	perl -pi -e 's/^TCP_IN = "(.*)"$/TCP_IN = "$1,35000:35999"/' ${CSF_CONF}
fi
C=`grep ^TCP6_IN ${CSF_CONF} | grep -c 3500`
if [ "$C" = "0" ]; then
	perl -pi -e 's/^TCP6_IN = "(.*)"$/TCP6_IN = "$1,35000:35999"/' ${CSF_CONF}
fi

perl -pi -e 's/SMTP_BLOCK = "0"$/SMTP_BLOCK = "1"/' ${CSF_CONF}
perl -pi -e 's/RESTRICT_SYSLOG = "0"$/RESTRICT_SYSLOG = "3"/' ${CSF_CONF}

echo "Install done."
echo "Before we start it up, please confirm that your sshd port is listed in this output:"
grep ^TCP_IN ${CSF_CONF}

echo "";
echo "If you do NOT see the port listed, press ctrl-c to immediately abort the script.";
echo "If you DO the port correctly added, press enter to continue";
read pressreturn;

service csf start

cd /usr/local/directadmin/scripts/custom/
wget --no-check-certificate -O block_ip.sh http://files.plugins-da.net/dl/csf_block_ip.sh.txt
wget --no-check-certificate -O unblock_ip.sh http://files.plugins-da.net/dl/csf_unblock_ip.sh.txt
wget --no-check-certificate -O show_blocked_ips.sh http://files.plugins-da.net/dl/csf_show_blocked_ips.sh.txt
wget --no-check-certificate -O brute_force_notice_ip.sh http://files.directadmin.com/services/all/brute_force_notice_ip.sh
chmod 700 block_ip.sh show_blocked_ips.sh unblock_ip.sh brute_force_notice_ip.sh

touch /root/blocked_ips.txt
touch /root/exempt_ips.txt

C=`grep -c hide_brute_force_notifications /usr/local/directadmin/conf/directadmin.conf`
if [ "$C" = "0" ]; then
	echo "hide_brute_force_notifications=1" >> /usr/local/directadmin/conf/directadmin.conf
fi


echo "";
echo ""
echo "Install complete!";
echo "To access the plugin, go to:";
echo "  Admin Level -> ConfigServer Firewall\&Security";
echo "";
echo "script based guide at https://help.poralix.com/articles/how-to-block-ips-with-csf-directadmin-bfm";
echo "";
 
exit 0;

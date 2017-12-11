echo "###################################################";
echo "#		       Debian Configuration     	#";
echo "###################################################";

echo "###################################################";
echo "#		       Sources Configuration   		#";
echo "###################################################";

debian_ver=`lsb_release -c -s`;

sed -i '/cdrom/ s/#*//' /etc/apt/sources.list;
sed -i '/cdrom/ s/^/#/' /etc/apt/sources.list;
echo "deb http://deb.debian.org/debian/ $debian_ver main contrib" >> /etc/apt/sources.list;
echo "deb-src http://deb.debian.org/debian/ $debian_ver main contrib" >> /etc/apt/sources.list;
#echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list;
apt-get -y -f install software-properties-common;
#add-apt-repository "deb http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main";
wget -q -O - http://dl.google.com/linux/linux_signing_key.pub | apt-key add -;

echo "==================================================";
echo "#		       Sources Configuration		#";
echo "==================================================";

echo "###################################################";
echo "#		       apt-get update           	#";
echo "###################################################";

apt update;
apt-get update;
apt-get upgrade;

apt-get -y install build-essential;
echo "===================================================";
echo "#		       build-essential			#";
echo "===================================================";

apt-get -f net-tools;
echo "===========================================";
echo "#		       net-tools                #";
echo "===========================================";

apt-get -y install git;
echo "===================================================";
echo "#		       git                              #";
echo "===================================================";

apt-get -y install sudo;
echo "kakashi ALL=(ALL:ALL) ALL" >> /etc/sudoers;
echo "===================================================";
echo "#		       sudo				#";
echo "===================================================";


apt-get -y install openssh-server;
#/etc/ssh/shhd_config
#/etc/init.d/ssh restart
rm /etc/ssh/ssh_host_*;
dpkg-reconfigure openssh-server;
sed -i '/Port/9 sed -i '/Port\ 22/ s/#*//' /etc/ssh/sshd_config;
echo "===========================================";
echo "#		       openssh-server                 #";
echo "===========================================";

apt-get -y -f install google-chrome-stable;
echo "===========================================";
echo "#		       google-chrome-stable           #";
echo "===========================================";





####
#apt-get -y install oracle-java8-installer;
#update-alternatives --config java
#update-alternatives --config command
#echo >> 'JAVA_HOME="/usr/lib/jvm/java-8-oracle"' >> /etc/enviroment;
#source /etc/enviroment;
#echo $JAVA_HOME;

echo "###########################################";
echo "#		Debian Configuration		#";
echo "###########################################";

echo "###########################################";
echo "#		Sources Configuration		#";
echo "###########################################";

sed -i '/cdrom/ s/#*//' /etc/apt/sources.list;
sed -i '/cdrom/ s/^/#/' /etc/apt/sources.list;

echo "====>update..."; 

apt update;
apt-get update;

echo "====>done";

echo "====>upgrade...";
apt-get upgrade;
echo "====>done";

echo "====>build essential";
apt-get -y install build-essential;
echo "====>done";

apt-get -f net-tools;

echo "====>install git";
apt-get -y install git;
echo "====>done";

echo "====>install sudo";
apt-get -y install sudo;
echo "kakashi ALL=(ALL:ALL) ALL" >> /etc/sudoers;


echo "====>install ssh"
apt-get -y install openssh-server;
echo "====>done";

echo "====>regenerate keys";

#/etc/ssh/shhd_config
#/etc/init.d/ssh restart
rm /etc/ssh/ssh_host_*;
dpkg-reconfigure openssh-server;
echo "====>done";

wget -q -O - http://dl.google.com/linux/linux_signing_key.pub | apt-key add -;
echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list;

apt-get update;
apt-get -y -f install google-chrome-stable;

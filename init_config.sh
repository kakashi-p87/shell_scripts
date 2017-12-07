echo "#####Debian configuration#####";
echo "====>update..."; 
apt-get update;
echo "====>done";

echo "====>upgrade...";
apt-get upgrade;
echo "====>done";

echo "====>build essential";
apt-get -y install build-essential;
echo "====>done";

echo "====>install git";
apt-get -y install git;
echo "====>done";

echo "====>install ssh"
apt-get -y install openssh-server;
echo "====>done";

echo "====>regenerate keys";
rm /etc/ssh/ssh_host_*;
dpkg-reconfigure openssh-server;
echo "====>done";


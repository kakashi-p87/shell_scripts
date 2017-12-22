echo "###################################################";
echo "#		             Debian Configuration     	      #";
echo "###################################################";

echo "Please provide your linux's user_name";
read user_name;

usermod -aG root $user_name;
echo "source /etc/enviroment" | tee -a /root/.bashrc;
source /etc/enviroment;

echo "###################################################";
echo "#		             Sources Configuration   		      #";
echo "###################################################";

debian_ver=`lsb_release -c -s`;

sed -i '/cdrom/ s/#*//' /etc/apt/sources.list;
sed -i '/cdrom/ s/^/#/' /etc/apt/sources.list;
echo "deb http://deb.debian.org/debian/ $debian_ver main contrib" | tee -a /etc/apt/sources.list;
echo "deb-src http://deb.debian.org/debian/ $debian_ver main contrib" | tee -a /etc/apt/sources.list;
#echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" | tee -a /etc/apt/sources.list;
apt-get -y -f install software-properties-common;
#add-apt-repository "deb http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main";
wget -q -O - http://dl.google.com/linux/linux_signing_key.pub | apt-key add -;

echo "===================================================";
echo "#		             Sources Configuration		        #";
echo "===================================================";

echo "###################################################";
echo "#		                 apt-get update           	  #";
echo "###################################################";

apt update;
apt-get update;
apt-get upgrade;

apt-get -y install build-essential;
echo "===================================================";
echo "#		               build-essential			          #";
echo "===================================================";

apt-get -f install net-tools;
echo "===================================================";
echo "#		                 net-tools                    #";
echo "===================================================";

apt-get -y install sudo;
echo "${user_name} ALL=(ALL:ALL) ALL" | tee -a /etc/sudoers;
echo "===================================================";
echo "#		       			       sudo                       #";
echo "===================================================";

sudo apt-get -f -y install maven;

echo "===================================================";
echo "#                     maven                       #";
echo "===================================================";

apt-get -y install openssh-server;
#/etc/ssh/shhd_config
#/etc/init.d/ssh restart
rm /etc/ssh/ssh_host_*;
dpkg-reconfigure openssh-server;
sed -i "/Port\ 22/ s/#*//" /etc/ssh/sshd_config;
echo "===================================================";
echo "#		               openssh-server                 #";
echo "===================================================";

apt-get -y -f install google-chrome-stable;
echo "===================================================";
echo "#     		       google-chrome-stable             #";
echo "===================================================";


echo "###################################################";
echo "#		             Git configuration        	      #";
echo "###################################################";

apt-get -y install git;

echo "please provide your e-mail";
read email_git;
echo "please provide your git's user name";
read user_git;

git config --global user.email "$email_git";
git config --global user.name  "$user_git";

repo_dir="/home/$user_name/Repository";

mkdir $repo_dir;
chown -R $user_name:$user_name $repo_dir;

mkdir "$repo_dir/shell_scripts";


git clone https://github.com/kakashi-p87/shell_scripts.git "$repo_dir/shell_scripts";



chown -R $user_name:$user_name $repo_dir/*

echo "===================================================";
echo "#		               git configured                 #";
echo "===================================================";

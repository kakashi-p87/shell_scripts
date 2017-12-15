echo "###########################################";
echo "#		       FTP configuration              #";
echo "###########################################";

ftp_conf="/etc/vsftp.conf";
local_root="/home/${USER}/ftp_home";
userlist_file="/etc/vsftpd.userlist";

sudo apt-get update;
sudo apt-get -y install vsftpd;
echo "===========================================";
echo "#		       vsftpd installed               #";
echo "===========================================";

sudo cp $ftp_conf /etc/vsftp.conf.orig;
sudo mkdir $local_root;
sudo chown nobody:nogroup $local_root;
sudo chmod a-w $local_root;

sudo mkdir ${local_root}/files;
sudo chown ${USER}:${USER} ${local_root}/files;

sudo sed -i "/write_enable=/ s/#*//" $ftp_conf;
sudo sed -i "/chroot_local_user=/ s/#*//" $ftp_conf;

#sudo chown -R root:${USER} $ftp_conf;
#sudo chmod -R g+w /etc/enviroment;

sudo echo "user_sub_token=${USER}"                    >> $ftp_conf;
sudo echo "local_root=${local_root}"                  >> $ftp_conf;
sudo echo "pasv_min_port=40000"                       >> $ftp_conf;
sudo echo "pasv_max_port=50000"                       >> $ftp_conf;
sudo echo "userlist_enable=YES"                       >> $ftp_conf;
sudo echo "userlist_file=${userlist_file}"            >> $ftp_conf;
sudo echo "userlist_deny=NO"                          >> $ftp_conf;

sudo echo "${USER}" >> $userlist_file;

sudo systemctl restart vsftpd;

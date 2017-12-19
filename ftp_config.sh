echo "###################################################";
echo "#		       FTP configuration              #";
echo "###################################################";

ftp_conf="/etc/vsftpd.conf";
local_root="/home/${USER}/ftp_home";
userlist_file="/etc/vsftpd.userlist";

sudo apt-get update;
sudo apt-get -f -y install vsftpd;
echo "===================================================";
echo "#		       vsftpd installed               #";
echo "===================================================";

sudo /etc/init.d/vsftpd stop;

echo "===================================================";
echo "#		       vsftpd stopped              #";
echo "===================================================";

sudo apt-get -f install xinetd;
echo "===================================================";
echo "#		       xinetd installed               #";
echo "===================================================";
vsftpd_file="/etc/xinetd.d/vsftpd";

sudo /etc/init.d/xinetd stop;

echo "===================================================";
echo "#		       xinetd stopped              #";
echo "===================================================";

echo "service ftp" 					                      | sudo tee -a $vsftpd_file;
echo "{"					                              	| sudo tee -a $vsftpd_file;
echo "	disable		       = no" 	                  | sudo tee -a $vsftpd_file;
echo "	socket_type	     = stream"		            | sudo tee -a $vsftpd_file;
echo "	wait		         = no"			              | sudo tee -a $vsftpd_file;
echo "	user		         = root"			            | sudo tee -a $vsftpd_file;
echo "	server		       = /usr/sbin/vsftpd"	    | sudo tee -a $vsftpd_file;
echo "	per_source	     = 5"			                | sudo tee -a $vsftpd_file;
echo "	instances	       = 200"			              | sudo tee -a $vsftpd_file;
echo "	no_access	       = 10.1.1.10"		          | sudo tee -a $vsftpd_file;
echo "	banner_fail	     = /etc/vsftpd.busy"	    | sudo tee -a $vsftpd_file;
echo "	log_on_success	 += PID HOST DURATION"	  | sudo tee -a $vsftpd_file;
echo "	log_on_failure	 += HOST"		              | sudo tee -a $vsftpd_file;
echo "}"						                              | sudo tee -a $vsftpd_file;

echo "===================================================";
echo "#		       xinetd configured              #";
echo "===================================================";

sudo /etc/init.d/xinetd start;

echo "===================================================";
echo "#		       xinetd started              #";
echo "===================================================";


echo "===================================================";
echo | netstat -ant | grep 21;
echo "===================================================";

sudo apt-get install ftp;
echo "===================================================";
echo "#		       ftp installed                  #";
echo "===================================================";

sudo cp $ftp_conf /etc/vsftpd.conf.orig;
sudo mkdir $local_root;
sudo chown nobody:nogroup $local_root;
sudo chmod a-w $local_root;

sudo mkdir ${local_root}/files;
sudo chown ${USER}:${USER} ${local_root}/files;

sudo sed -i -e "s/\(listen=\).*/\1NO/" $ftp_conf;
sudo sed -i -e "s/\(listen_ipv6=\).*/\1NO/" $ftp_conf;
#echo "no_anon_password=YES" | sudo tee -a $ftp_conf;

sudo sed -i "/write_enable=/ s/#*//" $ftp_conf;
sudo sed -i "/chroot_local_user=/ s/#*//" $ftp_conf;

#sudo chown -R root:${USER} $ftp_conf;
#sudo chmod -R g+w /etc/enviroment;

echo "user_sub_token=${USER}"                    | sudo tee -a $ftp_conf;
echo "local_root=${local_root}"                  | sudo tee -a $ftp_conf;
echo "pasv_min_port=40000"                       | sudo tee -a $ftp_conf;
echo "pasv_max_port=50000"                       | sudo tee -a $ftp_conf;
echo "userlist_enable=YES"                       | sudo tee -a $ftp_conf;
echo "userlist_file=${userlist_file}"            | sudo tee -a $ftp_conf;
echo "userlist_deny=NO"                          | sudo tee -a $ftp_conf;

echo "${USER}" | sudo tee -a $userlist_file;

sudo /etc/init.d/vsftpd restart;

sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/vsftpd.pem -out /etc/ssl/private/vsftpd.pem;

sudo sed -i '/rsa_cert_file=/ s/^/#/'         $ftp_conf;
sudo sed -i '/rsa_private_key_file=/ s/^/#/'  $ftp_conf;
sudo sed -i -e "s/\(ssl_enable=\).*/\1YES/"   $ftp_conf;


echo "rsa_cert_file=/etc/ssl/private/vsftpd.pem"         | sudo tee -a $ftp_conf;
echo "rsa_private_key_file=/etc/ssl/private/vsftpd.pem"  | sudo tee -a $ftp_conf;
echo "allow_anon_ssl=NO"                                 | sudo tee -a $ftp_conf;
echo "force_local_data_ssl=YES"                          | sudo tee -a $ftp_conf;
echo "force_local_logins_ssl=YES"                        | sudo tee -a $ftp_conf;
echo "ssl_tlsv1=YES"                                     | sudo tee -a $ftp_conf;
echo "ssl_sslv2=NO"                                      | sudo tee -a $ftp_conf;
echo "ssl_sslv3=NO"                                      | sudo tee -a $ftp_conf;
echo "require_ssl_reuse=NO"                              | sudo tee -a $ftp_conf;
echo "ssl_ciphers=HIGH"                                  | sudo tee -a $ftp_conf;


sudo /etc/init.d/vsftpd restart;
sudo /etc/init.d/xinetd restart;

sudo apt-get -y install filezilla;

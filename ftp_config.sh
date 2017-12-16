echo "###########################################";
echo "#		       FTP configuration              #";
echo "###########################################";

sudo apt-get -y install vsftpd;
echo "===========================================";
echo "#		       vsftpd installed               #";
echo "===========================================";

sudo apt-get install xinetd;
echo "===========================================";
echo "#		       xinetd installed               #";
echo "===========================================";

vsftpd_file="/etc/xinetd.d/vsftpd";

sudo echo -e "service ftp" 					                    >> $vsftpd_file;
sudo echo -e "{"					                              	>> $vsftpd_file;
sudo echo -e "	disable		= no" 	                    		>> $vsftpd_file;
sudo echo -e "	socket_type	= stream"		                  >> $vsftpd_file;
sudo echo -e "	wait		= no"			                        >> $vsftpd_file;
sudo echo -e "	user		= root"			                      >> $vsftpd_file;
sudo echo -e "	server		= /usr/sbin/vsftpd"	            >> $vsftpd_file;
sudo echo -e "	per_source	= 5"			                    >> $vsftpd_file;
sudo echo -e "	instances	= 200"			                    >> $vsftpd_file;
sudo echo -e "	no_access	= 10.1.1.10"		                >> $vsftpd_file;
sudo echo -e "	banner_fail	= /etc/vsftpd.busy"	          >> $vsftpd_file;
sudo echo -e "	log_on_success	+= PID HOST DURATION"	    >> $vsftpd_file;
sudo echo -e "	log_on_failure	+= HOST"		              >> $vsftpd_file;
sudo echo -e "}"						                              >> $vsftpd_file;

echo "===========================================";
echo "#		       xinetd configured              #";
echo "===========================================";

echo "==========================> stopping vsftpd";
sed -i -e "s/\(listen=\).*/\1NO/" /etc/vsftpd.conf;
sed -i -e "s/\(listen_ipv6=\).*/\1NO/" /etc/vsftpd.conf;
sudo echo "no_anon_password=YES" >> /etc/vsftpd.conf;
sudo /etc/init.d/vsftpd stop;

echo "===========================> restart xinetd";
#service xinetd restart;
sudo /etc/init.d/xinetd start;

echo "===========================> xinetd start";

echo | netstat -ant | grep 21;

sudo apt-get install ftp;
echo "===========================================";
echo "#		       ftp installed                  #";
echo "===========================================";

echo "=======================> adding  admin user";
sudo echo ${USER} | tee -a /etc/vsftpd.userlist;

vsftpd_conf=/etc/vsftpd.conf;
echo "userlist_file=/etc/vsftpd.userlist"		| tee -a $vsftpd_conf;
echo "userlist_enable=YES"				          | tee -a $vsftpd_conf;
echo "userlist_deny=NO"					            | tee -a $vsftpd_conf;
echo "local_root=/home/kakashi/ftp"			    | tee -a $vsftpd_conf;

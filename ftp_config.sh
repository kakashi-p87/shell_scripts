echo "###########################################";
echo "#		       FTP configuration              #";
echo "###########################################";

apt-get -y install vsftpd;
echo "===========================================";
echo "#		       vsftpd installed               #";
echo "===========================================";

apt-get install xinetd;
echo "===========================================";
echo "#		       xinetd installed               #";
echo "===========================================";

vsftpd_file="/etc/xinetd.d/vsftpd";

echo -e "service ftp" 					                    >> $vsftpd_file;
echo -e "{"					                              	>> $vsftpd_file;
echo -e "	disable		= no" 	                    		>> $vsftpd_file;
echo -e "	socket_type	= stream"		                  >> $vsftpd_file;
echo -e "	wait		= no"			                        >> $vsftpd_file;
echo -e "	user		= root"			                      >> $vsftpd_file;
echo -e "	server		= /usr/sbin/vsftpd"	            >> $vsftpd_file;
echo -e "	per_source	= 5"			                    >> $vsftpd_file;
echo -e "	instances	= 200"			                    >> $vsftpd_file;
echo -e "	no_access	= 10.1.1.10"		                >> $vsftpd_file;
echo -e "	banner_fail	= /etc/vsftpd.busy"	          >> $vsftpd_file;
echo -e "	log_on_success	+= PID HOST DURATION"	    >> $vsftpd_file;
echo -e "	log_on_failure	+= HOST"		              >> $vsftpd_file;
echo -e "}"						                              >> $vsftpd_file;

echo "===========================================";
echo "#		       xinetd configured              #";
echo "===========================================";

echo "==========================> stopping vsftpd";
sed -i -e "s/\(listen=\).*/\1NO/" /etc/vsftpd.conf;
sed -i -e "s/\(listen_ipv6=\).*/\1NO/" /etc/vsftpd.conf;
echo "no_anon_password=YES" >> /etc/vsftpd.conf;
/etc/init.d/vsftpd stop;

echo "===========================> restart xinetd";
#service xinetd restart;
/etc/init.d/xinetd start;

echo "===========================> xinetd start";

echo | netstat -ant | grep 21;

apt-get install ftp;
echo "===========================================";
echo "#		       ftp installed                  #";
echo "===========================================";

echo "=======================> adding  admin user";
echo "kakashi" > /etc/vsftpd.userlist;

vsftpd_conf=/etc/vsftpd.conf;
echo "userlist_file=/etc/vsftpd.userlist"		>> $vsftpd_conf;
echo "userlist_enable=YES"				          >> $vsftpd_conf;
echo "userlist_deny=NO"					            >> $vsftpd_conf;
echo "local_root=/home/kakashi/ftp"			    >> $vsftpd_conf;

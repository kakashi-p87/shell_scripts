echo "###################################################";
echo "#		       MySQL Configuration     	#";
echo "###################################################";

repo_mysql="mysql-apt-config_0.8.9-1_all.deb";
wget https://repo.mysql.com//${repo_mysql};

sudo apt-get --purge remove mysql-server;

sudo dpkg -i $repo_mysql;
sudo apt-get update;

sudo apt-get install mysql-server;
rm $repo_mysql;

sudo sed -i '/bind/ s/^/#/' /etc/mysql/mysql.conf.d/mysqld.cnf;
echo "bind-address=0.0.0.0" | sudo tee -a /etc/mysql/mysql.conf.d/mysqld.cnf

#sudo service mysql status;

sudo service mysql stop;

sudo service mysql start;

#sudo apt-get -y install mysql-workbench-community;


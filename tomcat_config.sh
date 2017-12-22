echo "###################################################";
echo "#                Tomcat Configuration             #";
echo "###################################################";


sudo apt-get update;
sudo apt-get install -y tomcat8;
sudo apt-get install -y tomcat8-admin tomcat8-examples tomcat8-docs;

echo "===================================================";
echo "#                Tomcat8 installed                 #"
echo "===================================================";

sudo sed -i "s/.*\/tomcat-users.*/<user\ username=\"admin\"\ password=\"password\"\ roles=\"manager-gui,admin-gui\"\/>\n&/" /etc/tomcat8/tomcat-users.xml;

sudo service tomcat8 restart;

echo "===================================================";
echo "#          Tomcat8 configuration finished         #"
echo "===================================================";

sudo apt-get install openjdk-11-jdk;

echo "JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64/" | sudo tee -a /etc/enviroment;
echo "source /etc/enviroment" | sudo tee -a ~/.bashrc;
sudo -s source /etc/enviroment;

echo "===================================================";
echo "#		     	    JAVA_HOME 	                #";
echo "#                     $JAVA_HOME                  #";
echo "===================================================";

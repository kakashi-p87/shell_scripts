wget --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/9.0.1+11/jdk-9.0.1_linux-x64_bin.tar.gz;
file_java="/opt/java/";
if [ -d "$file_java" ]; then
  sudo mkdir /opt/java/;
fi
sudo mv jdk-9.0.1_linux-x64_bin.tar.gz /opt/java/;
sudo tar -zxf /opt/java/jdk-9.0.1_linux-x64_bin.tar.gz /opt/java/;
sudo rm /opt/java/jdk-9.0.1_linux-x64_bin.tar.gz;

sudo update-alternatives --install /usr/bin/java java /opt/java/jdk-9.0.1/bin/java 100;
sudo update-alternatives --install /usr/bin/java javac /opt/java/jdk-9.0.1/bin/javac 100;

update-alternatives --config java;
update-alternatives --config javac;

echo `java -version`;
echo `javac -version`;

####
#apt-get -y install oracle-java8-installer;
#update-alternatives --config java
#update-alternatives --config command
#echo >> 'JAVA_HOME="/usr/lib/jvm/java-8-oracle"' >> /etc/enviroment;
#source /etc/enviroment;
#echo $JAVA_HOME;

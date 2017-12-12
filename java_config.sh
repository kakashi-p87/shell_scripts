echo "###################################################";
echo "#		       Java Configuration     	#";
echo "###################################################";
java_directory="/opt/java/";
jdk_directory="jdk-9.0.1/";
java_file="jdk-9.0.1_linux-x64_bin.tar.gz";

wget --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/9.0.1+11/${java_file};

if [ ! -d ${java_directory} ]; then
  sudo mkdir $java_directory;
fi

if [ ! -f ${java_directory}${java_file} ]; then
  sudo mv ${java_file} ${java_directory};
fi

if [ ! -d ${java_directory}${jdk_directory} ]; then
  sudo tar -zxf ${java_directory}${java_file} ${java_directory};
  sudo rm ${java_directory}${java_file};
fi

if [ ! -f ${java_file} ]; then
  sudo rm ${java_file};
fi

sudo update-alternatives --install /usr/bin/java java /opt/java/jdk-9.0.1/bin/java 100;
sudo update-alternatives --install /usr/bin/java javac /opt/java/jdk-9.0.1/bin/javac 100;

sudo update-alternatives --config java;
sudo update-alternatives --config javac;

echo `java -version`;
echo `javac -version`;

sudo echo >> 'JAVA_HOME="${java_directory}${jdk_directory}"' >> /etc/enviroment;
source /etc/enviroment;
echo $JAVA_HOME;

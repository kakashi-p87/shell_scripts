echo "###################################################";
echo "#		               Java Configuration     	      #";
echo "###################################################";
java_directory="/opt/java";
jdk_directory="/jdk-9.0.1";
java_file="jdk-9.0.1_linux-x64_bin.tar.gz";

if [ ! -f "$java_file" ]; then
  wget --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/9.0.1+11/${java_file};
  echo "$java_file downloaded";
fi

if [ ! -d "$java_directory" ]; then
  sudo mkdir $java_directory;
  echo "$java_directory created";
fi

if [ ! -d "$java_directory$jdk_directory" ]; then
  sudo tar -C '$java_directory' -f $java_file;
  echo "$java_file unzip";
fi

#if [ -f "$java_file" ]; then
#  sudo rm $java_file;
#fi

#if [ -f "$java_directory/$java_file" ]; then
#  sudo rm "$java_directory/$java_file";
#fi

sudo update-alternatives --install /usr/bin/java java $java_directory$jdk_directory/bin/java 100;
sudo update-alternatives --install /usr/bin/javac javac $java_directory$jdk_directory/bin/javac 100;

echo "###################################################";
echo "#		             Java Configuration               #";
echo "###################################################";
sudo update-alternatives --config java;
echo "###################################################";
echo "#		             javac Configuration   	          #";
echo "###################################################";
sudo update-alternatives --config javac;

echo "###################################################";
echo "#		                 Java Version     	          #";
echo "###################################################";
echo `java -version`;
echo "###################################################";
echo "#		            Java Compiler Version     	      #";
echo "###################################################";
echo `javac -version`;

echo "###################################################";
echo "#		                  JAVA_HOME     	            #";
echo "###################################################";
#sudo chown -R root:${USER} /etc/enviroment;
#sudo chmod -R g+w /etc/enviroment;
echo "JAVA_HOME='$java_directory$jdk_directory'" | tee -a /etc/enviroment;
sudo echo "source /etc/enviroment" | tee -a ~/.bashrc;
sudo -s source /etc/enviroment;
echo "===================================================";
echo "#		                  JAVA_HOME     	            #";
echo "#                     $JAVA_HOME                  #";
echo "===================================================";

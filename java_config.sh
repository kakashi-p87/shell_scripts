echo "###################################################";
echo "#		               Java Configuration     	      #";
echo "###################################################";
java_dir="/opt/java";
#jdk_dir="/jdk-9.0.1";
#java_file="jdk-9.0.1_linux-x64_bin.tar.gz";
jdk_dir="/jdk1.8.0_161";
java_file="jdk-8u161-linux-x64.tar.gz";

url_v='http://download.oracle.com/otn-pub/java/jdk/8u161-b12/2f38c3b165be4555a1fa6e98c45e0808/jdk-8u161-linux-x64.tar.gz';

if [ ! -f "$java_file" ]; then
  wget --header "Cookie: oraclelicense=accept-securebackup-cookie" $url_v; 
  #http://download.oracle.com/otn-pub/java/jdk/8u161-b12/2f38c3b165be4555a1fa6e98c45e0808/jdk-8u161-linux-x64.tar.gz; 
  #http://download.oracle.com/otn-pub/java/jdk/9.0.1+11/${java_file};
fi

if [ ! -f "$java_file" ]; then
  echo "Error: ${1:-"Unknown Error"}" 1>&2
  exit 1;
fi

echo "$java_file downloaded";

if [ ! -d "$java_dir" ]; then
  sudo mkdir $java_dir;
  echo "$java_dir created";
fi

if [ -d "$java_dir" ]; then
  sudo tar x -C $java_dir -f $java_file;
  rm $java_file;  
  echo "$java_file unzip";

  sudo chown -R root:root $java_dir;
  #sudo chmod -R g+w $java_directory;  

#if [ -f "$java_file" ]; then
#  sudo rm $java_file;
#fi

#if [ -f "$java_directory/$java_file" ]; then
#  sudo rm "$java_directory/$java_file";
#fi

  sudo update-alternatives --install /usr/bin/java java $java_dir$jdk_dir/bin/java 100;
  sudo update-alternatives --install /usr/bin/javac javac $java_dir$jdk_dir/bin/javac 100;

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
  echo "JAVA_HOME='$java_dir$jdk_dir'" | sudo tee -a /etc/enviroment;
  echo "source /etc/enviroment" | sudo tee -a ~/.bashrc;
  sudo -s source /etc/enviroment;
  echo "===================================================";
  echo "#		                  JAVA_HOME     	            #";
  echo "#                     $JAVA_HOME                  #";
  echo "===================================================";

fi

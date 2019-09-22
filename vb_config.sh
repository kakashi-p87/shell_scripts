#before this mount the virtualbox-guest iso in cdrom0
sudo apt-get update;
sudo apt-get upgrade;
sudo apt-get install -y -f dkms;
#sudo apt-get install -y -f virtualbox-guest-dkms;
#sudo apt-get install -f linux-headers-amd64;
#sudo apt-get install -f linux-headers-4.9.0-6-amd64;
#sudo sh /media/cdrom0/autorun.sh
sudo sh /media/cdrom0/VBoxLinuxAdditions.run

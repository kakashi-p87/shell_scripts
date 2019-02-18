sudo swapoff -a;

#kubernetes
sudo apt-get update && sudo apt-get install -y apt-transport-https curl;

#Add Google's apt repository gpg key
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -;

#Add the Kubernetes apt repository
sudo bash -c 'cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF';

sudo apt-get update;
sudo apt-get install -y kubelet kubeadm kubectl;
sudo apt-mark hold kubelet kubeadm kubectl;

#Check the status of our kubelet and our container runtime, docker.
#The kubelet will enter a crashloop until it's joined. echo `sudo systemctl status kubelet.service`;
echo ` sudo systemctl status docker.service`;

#Ensure both are set to start when the system starts up.
echo `sudo systemctl enable kubelet.service`
echo `sudo systemctl enable docker.service`


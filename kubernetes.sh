#kubernetes
sudo apt-get update && sudo apt-get install -y apt-transport-https curl;
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -;
sudo bash -c 'cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF';

sudo apt-get update;
sudo apt-get install -y kubelet kubeadm kubectl;
sudo apt-mark hold kubelet kubeadm kubectl;


echo `sudo systemctl status kubelet.service`;
echo ` sudo systemctl status docker.service`;

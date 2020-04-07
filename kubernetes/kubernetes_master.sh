sudo swapoff -a;

#Only on the master, download the yaml files for the pod network
if [ ! -f "rbac-kdd.yaml" ]; then
	wget https://docs.projectcalico.org/v3.3/getting-started/kubernetes/installation/hosted/rbac-kdd.yaml
fi

if [ ! -f "calico.yaml" ]; then
wget https://docs.projectcalico.org/v3.3/getting-started/kubernetes/installation/hosted/kubernetes-datastore/calico-networking/1.7/calico.yaml
fi

#Create our kubernetes cluster, specifying a pod network range matching that in calico.yaml!
sudo kubeadm init --pod-network-cidr=192.168.0.0/16

#Configure our account on the master to have admin access to the API server from a non-privileged account.
sudo mkdir -p $HOME/.kube;
echo sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
echo sudo chown $(id -u):$(id -g) $HOME/.kube/config

#Download yaml files for your pod network
echo `kubectl apply -f rbac-kdd.yaml`
echo `kubectl apply -f calico.yaml`

#Look for the all the system pods and calico pod to change to Running. The DNS pod won't start until the Pod network is deployed and Running.
echo `kubectl get pods --all-namespaces`

#Gives you output over time, rather than repainting the screen on each iteration.
#kubectl get pods --all-namespaces --watch

#Get a list of our current nodes, just the master.
echo `kubectl get nodes`


#Check out the systemd unit, and examine 10-kubeadm.conf Remeber the kubelet starts static pod manifests, and thus the core cluster pods
echo `sudo systemctl status kubelet.service`

#check out the directory where the kubeconfig files live
echo `ls /etc/kubernetes`

#let's check out the manifests on the master
echo `ls /etc/kubernetes/manifests`

#And look more closely at API server and etcd's manifest.
#sudo more /etc/kubernetes/manifests/etcd.yaml
#sudo more /etc/kubernetes/manifests/kube-apiserver.yaml

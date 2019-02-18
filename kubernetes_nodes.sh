#on master
#If you didn't keep the output, on the master, you can get the token.
kubeadm token list

#If you need to generate a new token, perhaps the old one timed out/expired.
kubeadm token create

#On the master, you can find the ca cert hash.
openssl x509 -pubkey -in /etc/kubernetes/pki/ca.crt | openssl rsa -pubin -outform der 2>/dev/null | openssl dgst
-sha256 -hex | sed 's/^.* //'

#on node
#Using the master (API Server) IP address or name, the token and the cert has, let's join this Node to our
#cluster.
sudo kubeadm join 172.16.94.10:6443 \
    --token #PASTE_TOKEN_HERE \
    --discovery-token-ca-cert-hash sha256:#PASTE_HASH_HERE

#kubeadm join --token abcdef.1234567890abcdef --discovery-token-unsafe-skip-ca-verification 1.2.3.4:6443`


#Back on master, this will say NotReady until the networking pod is created on the new node. Has to schedule the
#pod, then pull the container.
kubectl get nodes

#On the master, watch for the calico pod and the kube-proxy to change to Running on the newly added nodes.
#kubectl get pods --all-namespaces --watch

#Still on the master, look for this added node's status as ready.
kubectl get nodes

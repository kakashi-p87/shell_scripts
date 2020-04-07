#get all pods
kubectl get pods

#create deployment 
kubectl apply -f jenkins-deployment.yaml

#about pod
kubectl describe pods/jenkins-pod

#get deployments
kubectl get deployments

kubectl describe services/jenkins-deployment

kubectl expose deployment jenkins --type=LoadBalancer --name=jenkins-service

kubectl get services jenkins-service

kubectl describe services jenkins-service

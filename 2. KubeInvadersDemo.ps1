####################################################################################################################
####################################################################################################################
##
## https://github.com/dbafromthecold/pods-and-pages
##
## Chaos Engineering with KubeInvaders
## 
## Author - Andrew Pruski
## @dbafromthecold.com
## dbafromthecold@gmail.com
##
####################################################################################################################
####################################################################################################################



# set location for scripts
Set-Location C:\git\pods-and-pages



# switch context to cluster
kubectl config use-context kubeinvaders



# confirm connection to local cluster
kubectl get nodes



# deploy 20 pods running SQL Server
kubectl apply -f ./yaml/demo2/mssql-kubeinvaders.yaml



# view pods
kubectl get pods -o wide



# watch pods
kubectl get pods --watch



# clean up
kubectl delete statefulset mssql-kubeinvaders

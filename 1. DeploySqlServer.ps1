####################################################################################################################
####################################################################################################################
##
## Pods and Pages - Deploying stateful applications to Kubernetes
## 
##
##
## Faster, Safer Database Operations
## Author - Andrew Pruski
## apruski@purestorage.com
##
####################################################################################################################
####################################################################################################################




# set location for scripts
Set-Location C:\git\pods-and-pages



# set context
kubectl config use-context kubeinvaders



# test connection to cluster
kubectl get nodes -o wide



# confirm storage class
kubectl get storageclasses



# view yaml for secret
cat ./yaml/demo1/mssql-secret.yaml



# deploy secret
kubectl apply -f ./yaml/demo1/mssql-secret.yaml



# confirm secret
kubectl get secrets -o yaml



# decode secret
kubectl get secret mssql-sa-password -o jsonpath="{.data.MSSQL_SA_PASSWORD}" |
  ForEach-Object { [Text.Encoding]::UTF8.GetString([Convert]::FromBase64String($_)) }



# view statefulset yaml
cat ./yaml/demo1/mssql-statefulset.yaml



# deploy statefulset
kubectl apply -f ./yaml/demo1/mssql-statefulset.yaml



# confirm storaage
kubectl get pvc
kubectl get pv



# confirm statefulset
kubectl get sts



# confirm pod
kubectl get pods -o yaml



# describe pod and get QoS (BestEffort, Burstable, or Guaranteed)
# https://kubernetes.io/docs/concepts/workloads/pods/pod-qos/
# ensures that the nodes provide and commit the required resources
# least likely to face eviction
# guaranteed not to be killed until they exceed their limits or there are no lower-priority Pods that can be preempted from the Node 
# may not acquire resources beyond their specified limits
kubectl describe pod | Select-String "QoS Class"



# view yaml for service
cat ./yaml/demo1/mssql-service.yaml



# deploy service
kubectl apply -f ./yaml/demo1/mssql-service.yaml



# confirm service
kubectl get services



# grab service external IP address
$IP_ADDRESS=$(kubectl get service mssql-service -o jsonpath="{.status.loadBalancer.ingress[0].ip}"); echo $IP_ADDRESS



# test connection to SQL instance
Invoke-SqlCmd -ServerInstance $IP_ADDRESS -Database master -Username sa -Password "Testing1122" -Query "SELECT @@VERSION AS [Version];" | Format-Table


# clean up
kubectl delete statefulset mssql-statefulset
kubectl delete service mssql-service
kubectl delete secret mssql-sa-password
kubectl delete pvc --all

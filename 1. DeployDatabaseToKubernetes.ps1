####################################################################################################################
####################################################################################################################
##
## https://github.com/dbafromthecold/pods-and-pages
##
## Deploying databases to Kubernetes
## 
## Author - Andrew Pruski
## @dbafromthecold.com
## dbafromthecold@gmail.com
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



########################################################################################################################################
# snapshot demo



kubectl api-resources | select-string snapshot


kubectl apply -f ./yaml/demo1/volumesnapshotclass.yaml

kubectl get volumesnapshotclass


kubectl apply -f ./yaml/demo1/volumesnapshot.yaml



kubectl get volumesnapshots
kubectl describe volumesnapshot sqldata-snapshot


########################################################################################################################################
# probe demo



# remote into pod
kubectl exec -it mssql-statefulset-0 -- /bin/bash



# view processes 
ps aux



# kill the sql server process
kill -STOP 12



# view processes again and confirm that the sql server process is in a stopped state
ps -eo pid,state,cmd | grep '^.* T '



# exit out of the pod (if needed)
exit



# view pod events and confirm that the pod is restarted
kubectl describe pod mssql-statefulset-0



########################################################################################################################################



# clean up
kubectl delete statefulset mssql-statefulset
kubectl delete service mssql-service
kubectl delete secret mssql-sa-password
kubectl delete pvc --all

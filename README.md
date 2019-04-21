# Kubernetes demo

## Install kubectl

```
curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/darwin/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl
```

## Install minikube
rm -rf ~/.minikube

```curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-darwin-amd64 && chmod +x minikube ```

```sudo mv minikube /usr/local/bin```




## start minukube

```minikube start```


## Set docker 

eval $(minikube docker-env)


## Build docker service images

 - Build docker images 
 
 ```./start.sh build```

## Deploy to kubernetes 

 ```./start.sh deploy```

## Inspect kubernetes 

 ```kubectl get all```

 ```
 NAME                                    READY   STATUS    RESTARTS   AGE
pod/customer-service-75bd99568c-5r8xt   1/1     Running   0          6m33s
pod/customer-service-75bd99568c-v2z8d   1/1     Running   0          6m33s
pod/order-service-5c769cc64f-k58wz      1/1     Running   0          6m32s
pod/order-service-5c769cc64f-mszml      1/1     Running   0          6m32s

NAME                       TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)          AGE
service/customer-service   NodePort    10.109.247.3   <none>        8080:30501/TCP   6m33s
service/kubernetes         ClusterIP   10.96.0.1      <none>        443/TCP          12h
service/order-service      NodePort    10.99.235.65   <none>        8080:30500/TCP   6m32s

NAME                               READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/customer-service   2/2     2            2           6m33s
deployment.apps/order-service      2/2     2            2           6m32s

NAME                                          DESIRED   CURRENT   READY   AGE
replicaset.apps/customer-service-75bd99568c   2         2         2       6m33s
replicaset.apps/order-service-5c769cc64f      2         2         2       6m32s
```

## Test services

 ```./start.sh test```

 ```
Testing customer service
Testing  http://192.168.99.100:30501/api/v1/customerservice/health
{"instanceId":"99ab94d0-6479-11e9-b3cd-ade4c4a10d06","version":"1","status":"OK"}
Testing order service
Testing  http://192.168.99.100:30500/api/v1/orderservice/health
{"instanceId":"99bf43e0-6479-11e9-990e-911541fb516f","version":"1","status":"OK"}
 ```


 If you run again, you can see that the instance id changes between two values as we have two replicas for each service.


 ## Delete services

 ```./start.sh delete```

 ```
Delete customer service
deployment.apps "customer-service" deleted
service "customer-service" deleted
Delete order service
deployment.apps "order-service" deleted
service "order-service" deleted
```

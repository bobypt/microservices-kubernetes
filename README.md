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

## Set docker environment

eval $(minikube docker-env)

## Check versions
```kubectl version```

```
Client Version: version.Info{Major:"1", Minor:"14", GitVersion:"v1.14.1", GitCommit:"b7394102d6ef778017f2ca4046abbaa23b88c290", GitTreeState:"clean", BuildDate:"2019-04-08T17:11:31Z", GoVersion:"go1.12.1", Compiler:"gc", Platform:"darwin/amd64"}
Server Version: version.Info{Major:"1", Minor:"14", GitVersion:"v1.14.0", GitCommit:"641856db18352033a0d96dbc99153fa3b27298e5", GitTreeState:"clean", BuildDate:"2019-03-25T15:45:25Z", GoVersion:"go1.12.1", Compiler:"gc", Platform:"linux/amd64"}
```

## Build docker api images

- Build docker images 
 
```./start.sh build```

 ## Create a namespace

```kubectl create -f deployment/namespace.yaml```

output -> ```namespace/microservice-demo created```


```kubectl create -f deployment/resourceQuota.yaml```

output -> ```resourcequota/mem-cpu-quota created```


```kubectl describe ns microservice-demo```

```
Name:         microservice-demo
Labels:       apps=microservice-demo
Annotations:  type: demo
Status:       Active

Resource Quotas
 Name:            mem-cpu-quota
 Resource         Used  Hard
 --------         ---   ---
 limits.cpu       0     8
 limits.memory    0     6Gi
 requests.cpu     0     1
 requests.memory  0     1Gi

No resource limits.
```

## Deploy APIs

 ```./start.sh deploy```

## Inspect kubernetes 

 ```kubectl get all -n microservice-demo```

 ```
NAME                               READY   STATUS    RESTARTS   AGE
pod/customerapi-84fcfbb4bf-f267s   1/1     Running   0          5s
pod/customerapi-84fcfbb4bf-z24mw   1/1     Running   0          5s
pod/orderapi-5c76b8bbfc-5mdgv      1/1     Running   0          5s
pod/orderapi-5c76b8bbfc-lfrmp      1/1     Running   0          5s

NAME                  TYPE       CLUSTER-IP       EXTERNAL-IP   PORT(S)          AGE
service/customerapi   NodePort   10.110.186.222   <none>        8080:30501/TCP   5s
service/orderapi      NodePort   10.109.244.92    <none>        8080:30500/TCP   5s

NAME                          READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/customerapi   2/2     2            2           5s
deployment.apps/orderapi      2/2     2            2           5s

NAME                                     DESIRED   CURRENT   READY   AGE
replicaset.apps/customerapi-84fcfbb4bf   2         2         2       5s
replicaset.apps/orderapi-5c76b8bbfc      2         2         2       5s
```


```kubectl describe deployment  deployment.apps/customer-service -n microservice-demo```

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

## Check resource utilization
```kubectl describe ns microservice-demo```

```
Name:         microservice-demo
Labels:       apps=microservice-demo
Annotations:  type: demo
Status:       Active

Resource Quotas
 Name:            mem-cpu-quota
 Resource         Used   Hard
 --------         ---    ---
 limits.cpu       4      8
 limits.memory    4Gi    6Gi
 requests.cpu     800m   1
 requests.memory  512Mi  1Gi

No resource limits.
```

 ## Delete deployments and services

 ```./start.sh delete```

 ```
Delete customer service
deployment.apps "customer-service" deleted
service "customer-service" deleted
Delete order service
deployment.apps "order-service" deleted
service "order-service" deleted
```

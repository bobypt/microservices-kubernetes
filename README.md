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

## Create order service

```kubectl create -f services/orderservice/deployment/order-service-deployment.yml```

```kubectl create -f services/orderservice/deployment/order-service.yml```


```minikube service order-service  --url```

eg: http://192.168.99.100:30500


curl http://192.168.99.100:30500/api/v1/orderservice/health

{"instanceId":"e0ebd960-6413-11e9-88c3-f92051f8c7fc","version":"1","status":"OK"}



## delete service

```
kubectl get all
kubectl delete <name>
```
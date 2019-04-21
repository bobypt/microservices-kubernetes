#!/bin/bash

function build() {
    echo "Building customer api"
    pushd api/customerapi
    npm install
    docker build -t msdemo/customerapi:1 .
    popd

    echo "Building order api"
    pushd api/orderapi
    npm install
    docker build -t msdemo/orderapi:1 .
    popd
}

function deploy() {
    echo "Deploying customer api"
    kubectl create -f api/customerapi/deployment/customerapi-deployment.yml
    kubectl create -f api/customerapi/deployment/customerapi-service.yml

    echo "Deploying order api"
    kubectl create -f api/orderapi/deployment/orderapi-deployment.yml
    kubectl create -f api/orderapi/deployment/orderapi-service.yml
}

function test() {
    echo "Testing customer api"
    customerApiBasePath=$(minikube service customerapi -n microservice-demo --url)
    echo "Testing " ${customerApiBasePath}/api/v1/customerapi/health
    curl ${customerApiBasePath}/api/v1/customerapi/health

    echo "Testing order api"
    orderApiBasePath=$(minikube service orderapi -n microservice-demo --url)
    echo "Testing " ${orderApiBasePath}/api/v1/orderapi/health
    curl ${orderApiBasePath}/api/v1/orderapi/health    
}

function delete() {
    echo "Delete customer api"
    kubectl delete deployment.apps/customerapi -n microservice-demo
    kubectl delete service/customerapi -n microservice-demo

    echo "Delete order api"
    kubectl delete deployment.apps/orderapi -n microservice-demo
    kubectl delete service/orderapi -n microservice-demo
   
}

function options() {
      echo "./start build -> Build docker images"
}



for var in "$@"
do
  case "$var" in
    build)
      build
      ;;   
    deploy)
      deploy
      ;;       
    test)
      test
      ;;    
    delete)
      delete
      ;; 
    *)
      options
      ;;
  esac    
done


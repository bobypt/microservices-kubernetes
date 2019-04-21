#!/bin/bash

function build() {
    echo "Building customer service"
    pushd services/customerservice
    npm install
    docker build -t msdemo/customerservice:1 .
    popd

    echo "Building order service"
    pushd services/orderservice
    npm install
    docker build -t msdemo/orderservice:1 .
    popd
}

function deploy() {
    echo "Deploying customer service"
    kubectl create -f services/customerservice/deployment/customer-service-deployment.yml
    kubectl create -f services/customerservice/deployment/customer-service.yml

    echo "Deploying order service"
    kubectl create -f services/orderservice/deployment/order-service-deployment.yml
    kubectl create -f services/orderservice/deployment/order-service.yml
}

function test() {
    echo "Testing customer service"
    customerServiceBasePath=$(minikube service customer-service  --url)
    echo "Testing " ${customerServiceBasePath}/api/v1/customerservice/health
    curl ${customerServiceBasePath}/api/v1/customerservice/health

    echo "Testing order service"
    orderServiceBasePath=$(minikube service order-service  --url)
    echo "Testing " ${orderServiceBasePath}/api/v1/orderservice/health
    curl ${orderServiceBasePath}/api/v1/orderservice/health    
}

function delete() {
    echo "Delete customer service"
    kubectl delete deployment.apps/customer-service
    kubectl delete service/customer-service

    echo "Delete order service"
    kubectl delete deployment.apps/order-service
    kubectl delete service/order-service
   
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


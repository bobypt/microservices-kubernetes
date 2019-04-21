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


function options() {
      echo "./start build -> Build docker images"
}



for var in "$@"
do
  case "$var" in
    build)
      build
      ;;   
    *)
      options
      ;;
  esac    
done


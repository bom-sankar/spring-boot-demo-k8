#!/usr/bin/env bash

### build each service
cd demo-backend-k8
mvn clean install
cd ../demo-frontend-k8/
mvn clean install
cd ..

eval $(minikube docker-env)
kubectl create clusterrolebinding admin --clusterrole=cluster-admin --serviceaccount=default:default

### build the docker images on minikube
cd demo-backend-k8
docker build -t demo-backend .
cd ../demo-frontend-k8/
docker build -t demo-frontend .
cd ..

kubectl apply -f k8-definition.yaml

kubectl get pods
minikube service demo-frontend

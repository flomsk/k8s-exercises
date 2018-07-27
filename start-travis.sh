#!/bin/bash
echo "Deploying services"
cd kube
kubectl create ns airports-ns && kubectl create ns countries-ns
kubectl apply -f countries.yaml && kubectl apply -f ing-countries.yaml
kubectl rollout status deployment/countries -n countries-ns
kubectl apply -f airports.yaml && kubectl apply -f airports.yaml
kubectl rollout status deployment/airports -n airports-ns
IP=$(minikube ip)
echo "You can check your services at $IP"

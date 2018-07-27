#!/bin/bash
RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color
echo -e "${RED}Creating namespaces${NC}"
kubectl create ns airports-ns || echo -e "${CYAN}Airports NS already created${NC}"
kubectl create ns countries-ns || echo -e "${CYAN}Countries NS already created${NC}"
echo -e "${GREEN}Namespaces created${NC}"
echo -e "${CYAN}Choose service to deploy first: Countries | Airports${NC}"
read a
if [[ $a = Countries || $a = countries ]]; then
  echo -e "${GREEN}You choose Countries v1.0.1${NC}" && cd kube
  echo -e "${GREEN}Creating countries service${NC}"
  kubectl apply -f countries.yaml && kubectl apply -f ing-countries.yaml
  echo "$(minikube ip) countries.example.com" | sudo tee -a /etc/hosts
  echo -e "${RED}Wait about 2 minute for all probes to complete. You also can check status by running: "kubectl describe pod NAME"${NC}"
  echo -e "${RED}After initializing you can send some GET requests to http://countries.example.com${NC}"
else
  echo -e "${GREEN}You choose Airports service v1.0.1${NC}" && cd kube
  echo -e "${GREEN}Creating airports service${NC}"
  kubectl apply -f airports.yaml && kubectl apply -f ing-airports.yaml
  echo "$(minikube ip) airports.example.com" | sudo tee -a /etc/hosts
  echo -e "${RED}Wait about 2 minute for all probes to complete. You also can check status by running: "kubectl describe pod NAME"${NC}"
  echo -e "${RED}After initializing you can send some GET requests to http://airports.example.com${NC}"
fi
echo -e "${CYAN}Do you want to install other service? [Y,n]${NC}"
read input
if [[ $input == "Y" && $a = Countries || $input == "Y" && $a = countries || $input == "y" && $a = Countries || $input == "y" && $a = countries ]]; then
  echo -e "${GREEN}You choose Airports service v1.0.1${NC}"
  echo -e "${GREEN}Creating airports service${NC}"
  kubectl apply -f airports.yaml && kubectl apply -f ing-airports.yaml
  echo "$(minikube ip) airports.example.com" | sudo tee -a /etc/hosts
  echo -e "${RED}Wait about 2 minute for all probes to complete. You also can check status by running: "kubectl describe pod NAME"${NC}"
  echo -e "${RED}After initializing you can send some GET requests to http://airports.example.com${NC}"
  elif [[ $input == "Y" && $a = Airports || $input == "Y" && $a = airports || $input == "y" && $a = Airports || $input == "y" && $a = airports ]]; then
  echo -e "${GREEN}You choose Countries v1.0.1${NC}"
  echo -e "${GREEN}Creating countries service${NC}"
  kubectl apply -f countries.yaml && kubectl apply -f ing-countries.yaml
  echo "$(minikube ip) countries.example.com" | sudo tee -a /etc/hosts
  echo -e "${RED}Wait about 2 minute for all probes to complete. You also can check status by running: "kubectl describe pod NAME"${NC}"
  echo -e "${RED}After initializing you can send some GET requests to http://countries.example.com${NC}"
  elif [[ $input == "N" || $input == "n" ]]; then
  echo -e "${GREEN}Deploy finished${NC}"
fi

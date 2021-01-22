#!/bin/sh

GREEN='\e[92m'
YELLOW='\e[93m'
RED='\e[91m'
END='\e[0m'

echo -e "\n-------------------------------------------------------${YELLOW}MINICUBE START${END}---------------------------------------------------------------\n"
minikube start --cpus=4 --memory=10240 --vm-driver=virtualbox --extra-config=apiserver.service-node-port-range=1-32767
eval $(minikube docker-env)

echo -e "\n-------------------------------------------------------${YELLOW}BUILT CONTAINERS${END}-------------------------------------------------------------\n"
docker build -t nginx srcs/nginx > /dev/null 2>&1
echo -e "${RED} 10% ${END}"
docker build -t wordpress srcs/wordpress > /dev/null 2>&1
echo -e "${RED} 20% ${END}"
#docker build -t phpmyadmin srcs/phpmyadmin > /dev/null 2>&1
echo -e "${RED} 30% ${END}"
docker build -t mysql srcs/mysql > /dev/null 2>&1
echo -e "${GREEN} BUILT SUCKSESS ${END}"

echo -e "\n-------------------------------------------------------${YELLOW}DEPLOY${END}-----------------------------------------------------------------------\n"
kubectl apply -f srcs/secret.yaml
kubectl apply -f https://raw.githubusercontent.com/google/metallb/v0.8.1/manifests/metallb.yaml
kubectl apply -f srcs/metallbmap.yaml
kubectl apply -f srcs/wpmap.yaml
kubectl apply -f srcs/nginx.yaml
kubectl apply -f srcs/wordpress.yaml
#kubectl apply -f srcs/phpmyadmin.yaml
kubectl apply -f srcs/mysql.yaml

minikube addons enable dashboard

minikube dashboard
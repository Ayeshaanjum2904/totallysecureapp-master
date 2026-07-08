#!/bin/bash
cd "$(dirname $0)"
NAMESPACE=${NAMESPACE:-crapi}
kubectl create namespace $NAMESPACE

kubectl apply -n $NAMESPACE -f ./rbac
kubectl apply -n $NAMESPACE -f ./mongodb
kubectl apply -n $NAMESPACE -f ./postgres
kubectl apply -n $NAMESPACE -f ./mailhog
kubectl apply -n $NAMESPACE -f ./identity
kubectl apply -n $NAMESPACE -f ./community
kubectl apply -n $NAMESPACE -f ./workshop
kubectl apply -n $NAMESPACE -f ./web

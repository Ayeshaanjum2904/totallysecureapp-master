#!/bin/bash
cd "$(dirname $0)"
NAMESPACE=${K8S_NAMESPACE:-default}
MANIFEST_PATH=${K8S_MANIFEST_PATH:-./}

kubectl create namespace $NAMESPACE
#kubectl apply -f https://raw.githubusercontent.com/rancher/local-path-provisioner/master/deploy/local-path-storage.yaml

kubectl apply -n $NAMESPACE -f $MANIFEST_PATH/rbac
kubectl apply -n $NAMESPACE -f $MANIFEST_PATH/mongodb
kubectl apply -n $NAMESPACE -f $MANIFEST_PATH/postgres
kubectl apply -n $NAMESPACE -f $MANIFEST_PATH/mailhog
kubectl apply -n $NAMESPACE -f $MANIFEST_PATH/identity
kubectl apply -n $NAMESPACE -f $MANIFEST_PATH/community
kubectl apply -n $NAMESPACE -f $MANIFEST_PATH/workshop
kubectl apply -n $NAMESPACE -f $MANIFEST_PATH/web

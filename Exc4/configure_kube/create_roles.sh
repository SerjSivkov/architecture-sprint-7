#!/bin/bash

kubectl create clusterrole secrets-manager \
  --verb=get,create,delete,update \
  --resource=secrets

kubectl create clusterrole cluster-manager \
  --verb=get,list,create,delete,update \
  --resource=nodes,namespaces

# Функция для создания роли разработчика/devops в заданном неймспейсе
create_developer_role() {
  local namespace=$1
  kubectl create role ${namespace}-developer \
    --verb=get,list,create,delete,update \
    --resource=pods,services \
    -n $namespace
}

# Функция для создания роли для операционщиков в заданном неймспейсе
create_viewer_role() {
  local namespace=$1
  kubectl create role ${namespace}-viewer \
    --verb=get,list \
    --resource=pods,pods/log,services,events \
    -n $namespace
}

namespaces=("client" "tenant" "accounting" "analytics")
for ns in "${namespaces[@]}"; do
  create_developer_role $ns
  create_viewer_role $ns
done

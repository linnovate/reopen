#!/bin/bash -xe

chart=$1
namespace=$2
chart_path=../charts/$chart
deploy_name="${namespace}-${chart}"

helm delete --purge $deploy_name || echo "chart was not installed"
helm install --wait --name "$deploy_name -f values.$namespace.yaml --namespace "$namespace" $chart_path

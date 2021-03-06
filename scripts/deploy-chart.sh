#!/bin/bash -xe

declare ScriptDir && ScriptDir=$(readlink -f $(dirname ${0})) && cd ${ScriptDir}

chart=$1
namespace=$2
chart_path=../charts/$chart
deploy_name="${namespace}-${chart}"

helm delete --purge $deploy_name || echo "chart might not have been installed previously"
helm install --wait --name "$deploy_name" -f  "$chart_path/values.$namespace.yaml" --namespace "$namespace" $chart_path

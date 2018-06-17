#!/bin/bash -xe

chart=$1
namespace=$2
chart_path=../charts/$chart

helm delete --purge "${chart}-${namespace}" || echo "chart was not installed"
cp $chart_path/values.$namespace.yaml $chart_path/values.yaml

helm install --name "${chart}-${namespace}" --namespace "$namespace" $chart_path

rm $chart_path/values.yaml

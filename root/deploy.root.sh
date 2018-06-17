#!/bin/bash -xe

namespace=$1
chart_path=./root

helm delete --purge "root-$namespace" || echo "chart was not installed"
cp $chart_path/values.$namespace.yaml $chart_path/values.yaml

helm install --name "root-$namespace" --namespace "$namespace" $chart_path

rm $chart_path/values.yaml

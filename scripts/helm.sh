#!/bin/bash -xe

# deploys to namespace $Env
# ie dev
#
# Uses values of $ChartDir/values.$Env.yaml
# ie. recollect/values.dev.yaml

declare ScriptDir && ScriptDir=$(readlink -f -- $(dirname $0))

source $ScriptDir/functions.sh

declare Operation Env ChartsDir ChartValues ChartName Chart

Operation=$1
Chart=$2
Env=$3

ChartsDir=../charts
ChartsDir=$(real_path $ScriptDir $ChartsDir)

ChartName="$Env-$Chart"
ChartDir="$ChartsDir/$Chart"
ChartNamespace="$Env"
ChartValues="$ChartDir/values.$Env.yaml"

function helm_delete() {
    local chart_name
    chart_name=$1
    helm del --purge $chart_name || echo "Helm Chart was not installed!" >&2
}

function helm_install() {
    local chart_name chart_path chart_namespace chart_values

    chart_name=$1
    chart_path=$2
    chart_namespace=$3
    chart_values=$4

    helm install --wait --timeout 300 --namespace $chart_namespace -n $chart_name -f $chart_values $chart_path

#    helm install --wait --timeout 300 --namespace $chart_namespace -n $chart_name -f $chart_values $chart_path ||
#    helm upgrade --recreate-pods --wait --timeout 300 --namespace $chart_namespace -f $chart_values $chart_name $chart_path
}

if [ "$Operation" == "delete" ]; then
    helm_delete $ChartName
elif [ "$Operation" == "install" ]; then
    helm_install $ChartName $ChartDir $ChartNamespace $ChartValues
fi

# Really we should use upgrade, but upgrade currently does not seem to know how to work with new images with the latest tag (it uses the old cached images with :latest instead of the new ones) so for now we are just purging before install instead of using version tags on images

#helm upgrade dhapi ./helm/dhapi

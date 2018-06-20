#!/bin/bash
declare ScriptDir && ScriptDir=$(readlink -f -- $(dirname $0))

declare Env

Chart=$1
Env=$2

CHARTS_DIR=../charts

$ScriptDir/helm.sh delete $Chart $Env
$ScriptDir/helm-dep-build.sh $CHARTS_DIR
$ScriptDir/helm.sh install $Chart $Env

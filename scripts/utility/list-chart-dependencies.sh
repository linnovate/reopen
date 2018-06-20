#!/bin/bash -e

# example
# ./list-chart-dependencies.sh ../../helm

declare ScriptDir && ScriptDir=$(readlink -f -- $(dirname $0))

# since we are in a subdirectory
source $ScriptDir/../functions.sh

declare ChartsDir DependentCharts

ChartsDir=$1
ChartsDir=$(real_path $ScriptDir $ChartsDir)

DependentCharts=$($ScriptDir/find-dependent-charts.sh $ChartsDir)

for Chart in $DependentCharts; do
  echo $Chart ======================;
  helm dependency list $Chart
done


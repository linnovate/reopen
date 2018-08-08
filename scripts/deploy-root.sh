#!/bin/bash -xe

declare ScriptDir && ScriptDir=$(readlink -f $(dirname ${0})) && cd ${ScriptDir}

namespace=$1

./deploy-chart.sh root $namespace

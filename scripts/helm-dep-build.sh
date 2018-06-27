#!/bin/bash 

declare ScriptDir && ScriptDir=$(readlink -f -- $(dirname $0))

source $ScriptDir/functions.sh

declare ChartsDir

ChartsDir=$1
ChartsDir=$(real_path $ScriptDir $ChartsDir)

#helm dep build $ChartsDir/root
helm dep build $ChartsDir/recollect

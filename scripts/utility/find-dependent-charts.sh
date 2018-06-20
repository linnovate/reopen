#!/bin/bash -e

declare ScriptDir && ScriptDir=$(readlink -f -- $(dirname $0))

# since we are in a subdirectory
source $ScriptDir/../functions.sh

declare ChartsDir

ChartsDir=$1
ChartsDir=$(real_path $ScriptDir $ChartsDir)

find $ChartsDir -name *requirements.y*ml | xargs -L 1 dirname



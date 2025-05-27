#!/bin/sh

scriptName="${0##*/}"
fullDirName=$PWD
a="${PWD##*/}"
projectName=${a##*-}${RUNENV}

echo "Project = $projectName @ $scriptName @ $fullDirName"

./stop.sh
docker container rm ${projectName} -f



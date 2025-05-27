#!/bin/sh

scriptName="${0##*/}"
fullDirName=$PWD
a="${PWD##*/}"
projectName=${a##*-}${RUNENV}
imageName=`cat 0-imagename`

echo "imageName = $imageName"
echo "Project = $projectName @ $scriptName @ $fullDirName"

./stop.sh
./remove.sh
docker pull $imageName
./run.sh



#!/bin/sh

scriptName="${0##*/}"
fullDirName=$PWD
a="${PWD##*/}"
projectName=${a##*-}${RUNENV}



echo "Project = $projectName @ $scriptName @ $fullDirName"

docker container stop ${projectName} -t 5
docker ps


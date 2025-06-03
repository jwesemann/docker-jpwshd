#!/bin/sh

scriptName="${0##*/}"
fullDirName=$PWD
a="${PWD##*/}"
projectName=${a##*-}



echo "Project = $projectName @ $scriptName @ $fullDirName"


docker restart ${projectName}
docker ps


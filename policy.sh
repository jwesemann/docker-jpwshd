#!/bin/sh

scriptName="${0##*/}"
fullDirName=$PWD
a="${PWD##*/}"
projectName=${a##*-}



echo "Project = $projectName @ $scriptName @ $fullDirName"


docker update --restart=unless-stopped ${projectName}
#'no', 'always', 'on-failure:3', or 'unless-stopped'

docker inspect --format '{{json .HostConfig.RestartPolicy}}' ${projectName}



scriptName="${0##*/}"
fullDirName=$PWD
a="${PWD##*/}"
projectName=${a##*-}${RUNENV}
imageName=`cat 0-imagename`
dockerRun=`cat 1-dockerrun`
echo "dockerRun = $dockerRun"
echo "imageName = $imageName"


echo "Project = $projectName @ $scriptName @ $fullDirName"

docker exec -it $projectName /bin/bash
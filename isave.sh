#!/bin/sh

scriptName="${0##*/}"
fullDirName=$PWD
a="${PWD##*/}"
projectName=${a##*-}
imageName=`cat 0-imagename`
echo "imageName = $imageName"

echo "Project = $projectName @ $scriptName @ $fullDirName"

docker image save --output "${projectName}.image.tar" $imageName
#zip -1 ${projectName}.image.tar.zip "${projectName}.image.tar"
#zip -T ${projectName}.image.tar.zip
7z a -mx3 "${projectName}.image.tar.7z" "${projectName}.image.tar"
7z t "${projectName}.image.tar.7z"


if [ -f ${projectName}.image.tar.7z ]
then
    echo "File ${projectName}.image.tar.7z exists -> deleting tar"
    rm -f ${projectName}.image.tar
else
    echo "File ${projectName}.image.tar.7z does not exist-> NOT deleting tar"
fi



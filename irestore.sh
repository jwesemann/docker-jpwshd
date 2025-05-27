#!/bin/sh

scriptName="${0##*/}"
fullDirName=$PWD
a="${PWD##*/}"
projectName=${a##*-}

echo "Project = $projectName @ $scriptName @ $fullDirName"


#unzip -o ${projectName}.image.tar.zip 
7z e "${projectName}.image.tar.7z"
echo "Loading image "${projectName}.image.tar into docker"
docker load --input "${projectName}.image.tar"

if [ -f ${projectName}.image.tar.7z ]
then
    echo "File ${projectName}.image.tar.7z exists -> deleting tar"
    rm -f ${projectName}.image.tar
else
    echo "File ${projectName}.image.tar.7z does not exist-> NOT deleting tar"
fi
#!/bin/sh
RUNENV=""
scriptName="${0##*/}"
fullDirName=$PWD
a="${PWD##*/}"
projectName=${a##*-}${RUNENV}
imageName=`cat 0-imagename`
dockerRun=`cat 1-dockerrun`
echo "dockerRun = $dockerRun"
echo "imageName = $imageName"
echo "Project = $projectName @ $scriptName @ $fullDirName"


DDIR="${fullDirName}/datadir${RUNENV}"
echo "DDIR = $DDIR"
WDIR=${DDIR}/workdir
echo "WDIR = $WDIR"
CNAME=${projectName}
echo "CNAME = $CNAME"

if [ -d "$DDIR" ]; then
	echo "$DDIR already exists"
else
	echo "creating directory $DDIR"
	mkdir  "$DDIR"
fi

if [ -d "$WDIR" ]; then
	echo "$WDIR already exists"
else
	echo "creating directory $WDIR"
	mkdir  "$WDIR"
fi


touch ${WDIR}/JMonitor.csv
eval "$dockerRun"
docker ps
tail -f ${WDIR}/JMonitor.csv


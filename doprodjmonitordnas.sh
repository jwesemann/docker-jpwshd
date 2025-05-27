#!/bin/sh

RUNENV=""
DDIR="/volume1/docker/docker-jpwshd-debian/datadir${RUNENV}"
WDIR=${DDIR}/workdir
CNAME=jpwshd_debian12.8_pwsh7.4.6${RUNENV}

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
sudo docker run --name $CNAME --restart=always --env PWSHSCRIPTFILE=JMonitor.ps1 -d -v ${WDIR}:/root/workdir  weseit/pwshddebian12
tail -f ${WDIR}/JMonitor.csv

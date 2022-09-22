#!/bin/sh

RUNENV=""
DDIR="/volume1/docker/docker-jpwshd-debian/datadir${RUNENV}"
WDIR=${DDIR}/workdir

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
sudo docker run --name jwe_jmonitord_debian11_pwsh72${RUNENV} --restart=always --env PWSHSCRIPTFILE=JMonitorDebian11.ps1 -d -v ${WDIR}:/root/workdir  weseit/pwshddebian11
tail -f ${WDIR}/JMonitorDebian11.csv

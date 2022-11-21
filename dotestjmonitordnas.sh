#!/bin/sh

RUNENV="_test"
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
docker run --rm --name jwe_jmonitord_debian11_pwsh73${RUNENV} --env PWSHSCRIPTFILE=JMonitor.ps1 -d -v ${WDIR}:/root/workdir  weseit/pwshddebian11
tail -f ${WDIR}/JMonitor.csv

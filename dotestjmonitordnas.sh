#!/bin/sh
#mkdir /volume1/docker/shared/jmonitord
WDIR="/volume1/docker/jpwshd/devdir/docker-jpwshd-debian/workdir"
if [ -d "$WDIR" ]; then
	echo "$WDIR already exists"
else
	echo "creating directory $WDIR"
	mkdir  "$WDIR"
fi

touch ./workdir/JMonitor.csv
docker run --name jwe_jmonitord_debian11_test --rm --env PWSHSCRIPTFILE=JMonitor.ps1 -d -v /volume1/docker/jpwshd/devdir/docker-jpwshd-debian/workdir:/root/workdir  weseit/pwshddebian11
tail -f ./workdir/JMonitor.csv

#!/bin/sh
#mkdir /volume1/docker/shared/jmonitord
#mkdir /volume1/docker/jpwshd/devdir/docker-jpwshd-debian/workdir
docker run --name jwe_jmonitord_debian11_test --restart always --env PWSHSCRIPTFILE=JMonitor.ps1 -d -v /volume1/docker/jpwshd/devdir/docker-jpwshd-debian/workdir:/root/workdir  weseit/pwshddebian11
tail -f ./workdir/JMonitor.csv

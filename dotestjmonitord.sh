#!/bin/sh
#mkdir /volume1/docker/shared/jmonitord
#mkdir /volume1/docker/shared/jmonitord/workdir
docker run --name jwe_jmonitord_debian11 --restart always --env PWSHSCRIPTFILE=JMonitor.ps1 -d -v /mnt/c/Users/jwesemann/Documents/jwedev/3d/docker_jpwshd-debian10/workdir:/root/workdir  weseit/pwshddebian11
tail -f ./workdir/JMonitor.csv
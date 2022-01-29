#!/bin/sh
#mkdir /volume1/docker/shared/jmonitord
#mkdir /volume1/docker/shared/jmonitord/workdir
docker run --name jwe_jmonitord_debian11 --restart always --env PWSHSCRIPTFILE=JMonitor.ps1 -d -v C:\Users\jwesemann\Documents\jwedev\3d\docker_jpwshd-debian/workdir:/root/workdir  weseit/pwshddebian11
get-content -wait -tail 5 ./workdir/JMonitor.csv

#!/bin/sh
#mkdir /volume1/docker/jpwshd/datadir/
#mkdir /volume1/docker/jpwshd/datadir/workdir
docker run --name jwe_jmonitord_debian11_pwsh72 --restart always --env PWSHSCRIPTFILE=JMonitorDebian11.ps1 -d -v /volume1/docker/jpwshd/datadir/workdir:/root/workdir  weseit/pwshddebian11
tail -f /volume1/docker/jpwshd/datadir/workdir/JMonitorDebian11.csv

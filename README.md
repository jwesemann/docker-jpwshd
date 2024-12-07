# docker-jpwshd-debian

## Overview

This small framework can be used to start (looping) Powershell-Scripts in a well defined unix server environment acting as "server daemons".

It uses a debian Docker-image from Microsoft Powershell team with additional German locales to start a script (default or configured by environment variable). Please visit <https://hub.docker.com/_/microsoft-powershell> for more information about these Docker-images.

To make this implementation run on ARM devices like the Raspberyy PI-4 (my development environment) I added 2nd Dockerfile-armv8 which is not dependent on the Microsoft Docker image anymore but only on the official Debian image `debian:latest`. It will install powershell into /root/powershell and run /root/powershell/pwsh . Please visit <https://hub.docker.com/_/debian> to get more information on the used Debian image.

The included script `JMonitor.ps1` periodically pings (ICMP request) a well defined webserver and writes the times needed into a CSV-file. Any pre-existing files will be reused (not overwritten) and the output data will be appended to the CSV-file.


In general this `Dockerfile` and the underlying simple scripts should run in several environments : Windows 10/11 native, Windows 10/11 WSL Ubuntu 20.04, Synology DSM718+, Kali-Linux native . I plan to extend this to be an multi-architecture docker image for my Raspberry 3/4 but need some learning how to achieve this.

## Startup-Hook

The startup-hook is an implicite one. A standard Powershell profile `Microsoft.PowerShell_profile.ps1` will be copied into the default directory (created in the Dockerfile) `/home/root/.config/powershell`.

The shell-code makes sure that the main functional loop will **only be started if no other instance** of a powershell is already running within its container. This behavior makes it possible to attach an interactive terminal into the running conatiner for debugging purposes.

## Core Files

* `Dockerfile` : based on Microsofts official Powershell image for Debian
* `dobuild.sh` : Starts the docker build sequence based on Microsofts docker image
* `Dockerfile_armv8` : based on Debians docker image. Will add Powershell with own install routines. So no dependency on Microsoft docker repo anymore.
* `dobuild-armv8.sh` : Starts the docker build sequence based on Debians latest docker image
* `Microsoft.PowerShell_profile.ps1` : Checking environment variable PWSHSCRIPTFILE and directory "/root/workdir" which is mounted to the docker host to decide which specific Powershell-script will be started
* `JStandard.ps1` : small Powershell-script which will be copied from the image into workdir and being started if no valid combination to run from the environment-variable and directory-content is found
* `JMonitor.ps1` : The initial script I wrote for my client PC to monitor ICMP-performance of my internet connection. It is based on a much older NT-CMD version. Target of this project was to make this functionality  available in docker on my different servers (Synology NAS 718+, Raspberry Pi, Windows) to run 24/7/365 independently from my client workstation. I already collected > 1 million data points giving me an interesting overview over the behavior and quality of the internet line and the reliability of my internal network (router / NAS downtimes)
* Additional do-Scripts in the root or other directory : only to help me to remember build/save/run-commands several month later. I am not a developer which uses this stuff on a daily basis and I often forget details of created projects during time :-)
  * `dobuild.sh` : Creates a new docker image based on current `Dockerfile`
  * `dojmonitord.sh` : Runs a docker container with the image `weseit/pwshddebian11`
  * `dorenamegitbranch.ps1` : Does git actions after a remote branch has been renamed
  * `dosave.sh` : Saves the docker image `weseit/pwshddebian11` into `weseit_pwshddebian11.tar.gz`
  * `dosetgitremote.ps1` : set remote git url to a ssh based one
  * `dotestjmonitord.ps1` : Runs a test container with working mounted to `./workdir` on Windows Powershell
  * `dotestjmonitord.sh` : Outdated, May be reused later for another Linux environment to start a test container with specific path settings
  * `dotestjmonitordnas.sh` : Runs a test container with working mounted to `./workdir` on my Synology NAS environment
  * `JMonitor.ps1` : The main monitor Powershell script doing the ICMP/ping requests and writing data into the CSV-file for further processing.
  * `JStandard.ps1` : Standard Powershell script in container. Writes startup messages and immediately exits, destroying the container. Will be run only of the environment variable `PWSHSCRIPTFILE` is not set within the container.
* `Microsoft.PowerShell_profile.ps1` : Powershell standard autostart file under Linux. Located in `~/.config/powershell` . Implements extra logic to guarantee a save working environment. Starts a standard script only if no special script is named using the environment variable `PWSHSCRIPTFILE`. Even if such a script is named it will first look if it exists in the mounted working directory and will use this as a first choice. If there is no existing script in trhe working directoy it will copy it form the container itself. If nothing is being found there it will exit the container. The script will be started only if there is no powershell-process already running. This is the case if the container starts. If a terminal is being started/attached from external it will not start the main monitor script and just acts as an interactive shell e.g. for debugging purpuses.
* Currently missing in this repo: My private reporting MS-Excel sheet using the CSV as a database input and showing the graphical output. I plan to use the CSV to learn about Grafana/InfluxDB later if I find some time. But for now Excel does the job. A demo output can be found at this screenshoot ![screenshootExcel1](JMonitorExcelSnapshoot.png).

# docker_jpwshd-debian10

**Overview**

Use a lts-debian-buster-slim image from Microsoft Powershell team with additional German locales to start a script (default or configured by environment variable).

The included script "JMonitor.ps1" periodically pings (ICMP request) a well defined webserver and writes the times needed into a CSV-file. Any preexistung files will be reused (not overwritten) and the output CSV-file will be extendend.

This little framework can be used to start (looping) Powershell-Scripts in a well defined unix server environment acting as "server daemons".

In general this Dockerfile and the underlying simple scripts should run in 3 environments : Windows 10 native, Windows 10 WSL Ubuntu 20.04, Synology DSM718+ . I plan to extend this to be an multi-architecture docker image for my Raspberry 3/4 but need some learning how to achieve this.

**Startup-Hook**

The startup-hook is an implicite one. A standard Powershell profile "Microsoft.PowerShell_profile.ps1" willbe copied into the default directory (created in the Dockerfile) "/home/root/.config/powershell".

**Core Files**

* Dockerfile : based on Microsofts official Powershell image for Debian-Buster-LTS
* Microsoft.PowerShell_profile.ps1 : Checking environment variable PWSHSCRIPTFILE and directory "/root/workdir" which is mounted to the docker host to decide which specific Powershell-script will be started
* JStandard.ps1 : small Powershell-script which will be copied from the image into workdir and being started if no valid combination to run from the environment-variable and directory-content is found
* JMonitor.ps1 : The initial script I wrote for my client PC to monitor ICMP-performance of my internet connection. Based on a much older NT-CMD version. Target of this small docker project was to make this available in docker on my different servers (Synology NAS 718+, Raspberry Pi) to run idependently from my client workstation
* do-Scripts : only to help me to remember build/save/run-commands several month later. I am not a developer which uses this stuff on a daily basis and I often forget details of created projects during time :-)
* Missing : MS-Excel sheet using the CSV as a database input and showing the graphical output. I plan to use the CSV to learn about Grafana/InfluxDB later if I find some time. But for now Excel does the job.

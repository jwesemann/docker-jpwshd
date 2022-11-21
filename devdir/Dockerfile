#FROM mcr.microsoft.com/powershell:7.2.1-debian-bullseye-slim-20211215
FROM mcr.microsoft.com/powershell:7.3-debian-bullseye-slim

ENV LANG de_DE.UTF-8 
ENV LC_ALL de_DE.UTF-8
ENV LANGUAGE de_DE.UTF-8
ENV TZ 'Europe/Berlin'
ENV POWERSHELL_TELEMETRY_OPTOUT 1

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y locales \
    && sed -i -e 's/# de_DE.UTF-8 UTF-8/de_DE.UTF-8 UTF-8/' /etc/locale.gen \
    && dpkg-reconfigure --frontend=noninteractive locales \
    && update-locale LANG=de_DE.UTF-8 \
    && apt-get -y install tzdata \
    && ln -fs /usr/share/zoneinfo/Europe/Berlin /etc/localtime \
    && dpkg-reconfigure --frontend=noninteractive tzdata

#RUN touch /root/.jwedocker
WORKDIR /root
RUN touch .jwedocker \
    && mkdir .config \
    && mkdir .config/powershell \
    && mkdir workdir
COPY Microsoft.PowerShell_profile.ps1 .config/powershell
COPY JMonitor.ps1 .
COPY JStandard.ps1 .


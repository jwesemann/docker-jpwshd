#FROM mcr.microsoft.com/powershell:7.2.1-debian-bullseye-slim-20211215
FROM debian:12.8-slim

ENV LANG=de_DE.UTF-8 
ENV LC_ALL=de_DE.UTF-8
ENV LANGUAGE=de_DE.UTF-8
ENV TZ='Europe/Berlin'
ENV POWERSHELL_TELEMETRY_OPTOUT=1
ENV DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=1

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y locales \
    && sed -i -e 's/# de_DE.UTF-8 UTF-8/de_DE.UTF-8 UTF-8/' /etc/locale.gen \
    && dpkg-reconfigure --frontend=noninteractive locales \
    && update-locale LANG=de_DE.UTF-8 \
    && apt-get -y install tzdata \
    && ln -fs /usr/share/zoneinfo/Europe/Berlin /etc/localtime \
    && dpkg-reconfigure --frontend=noninteractive tzdata \
    && apt-get install -y wget


# replaced by apt install of pwsh to get all dependencies like lib-icu
#    && wget https://github.com/PowerShell/PowerShell/releases/download/v7.4.2/powershell-7.4.2-linux-musl-x64.tar.gz \
#    && mkdir ~/powershell \
#    && tar -xvf ./powershell-7.4.2-linux-musl-x64.tar.gz -C ~/powershell \
#    && chmod ugo+x ~/powershell/pwsh \
#    && rm -f /powershell*.tar.gz

WORKDIR /root

RUN wget https://github.com/PowerShell/PowerShell/releases/download/v7.5.1/powershell_7.5.1-1.deb_amd64.deb \
    && apt install -y ./powershell_7.5.1-1.deb_amd64.deb \
    && rm ./powershell_*.deb

RUN touch .jwedocker \
    && mkdir .config \
    && mkdir .config/powershell \
    && mkdir workdir
COPY Microsoft.PowerShell_profile.ps1 .config/powershell
COPY JMonitor.ps1 .
COPY JStandard.ps1 .

CMD ["/usr/bin/pwsh"]
#ENTRYPOINT ["tail", "-f", "/dev/null"]


FROM debian:bookworm-slim
# FROM debian:trixie-slim
# FROM debian:stable-slim
# debian13 (trixie) is not working yet, see https://github.com/PowerShell/PowerShell/pull/25866

ENV LANG=de_DE.UTF-8 
ENV LC_ALL=de_DE.UTF-8
ENV LANGUAGE=de_DE.UTF-8
ENV TZ='Europe/Berlin'
ENV POWERSHELL_TELEMETRY_OPTOUT=1
ENV DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=0

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

# Update URL for newest powershell version
RUN wget -O powershell.deb https://github.com/PowerShell/PowerShell/releases/download/v7.5.2/powershell_7.5.2-1.deb_amd64.deb \
    && apt install -y ./powershell.deb \
    && rm ./powershell.deb

RUN touch .jwedocker \
    && mkdir .config \
    && mkdir .config/powershell \
    && mkdir workdir
COPY Microsoft.PowerShell_profile.ps1 .config/powershell
COPY JMonitor.ps1 .
COPY JStandard.ps1 .

CMD ["/usr/bin/pwsh"]
#ENTRYPOINT ["tail", "-f", "/dev/null"]


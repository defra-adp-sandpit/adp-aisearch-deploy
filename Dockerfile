# Builder Stage
FROM ubuntu:jammy

USER root

RUN apt-get update && \
    apt-get install -y wget apt-transport-https software-properties-common && \
    wget -q "https://packages.microsoft.com/config/ubuntu/22.04/packages-microsoft-prod.deb" -O packages-microsoft-prod.deb && \
    dpkg -i packages-microsoft-prod.deb && \
    apt-get update && \
    apt-get install -y powershell postgresql-client && \
    apt-get clean && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/* /packages-microsoft-prod.deb

RUN pwsh -Command "Set-PSRepository -Name PSGallery -InstallationPolicy Trusted"
RUN pwsh -Command "Install-Module -Name Az.Accounts -Force -AllowClobber"
RUN pwsh -Command "Install-Module -Name Az.KeyVault -Force -AllowClobber"

WORKDIR /

COPY Modules ./Modules
COPY main.ps1 ./

ENV PSModulePath="/Modules"

SHELL ["pwsh", "-Command"]

ENTRYPOINT ["pwsh", "-File", "/main.ps1"]
CMD ["-h"]
FROM mcr.microsoft.com/windows/servercore:ltsc2022-KB5032198-amd64
LABEL authors="Selenium <selenium-developers@googlegroups.com>"

#================================================
# Customize sources for powershell
#================================================
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

#========================
# Miscellaneous packages
# Includes minimal runtime used for executing non GUI Java programs
#========================
RUN Install-PackageProvider -Name NuGet -Force -Verbose -Scope CurrentUser; \
    Install-Module -Name PowerShellGet -Force -AllowClobber -Verbose -Scope CurrentUser; \
    Install-Module -Name Chocolatey -Force -AllowClobber -Verbose -Scope CurrentUser -RequiredVersion 2.2.1; \
    choco feature enable -n allowGlobalConfirmation; \
    choco install -y openjdk11 curl unzip jq; \
    Remove-Item -Force -Recurse ${Env:TEMP}\*

#===================
# Timezone settings
# Possible alternative: https://github.com/docker/docker/issues/3359#issuecomment-32150214
#===================
ENV TZ "UTC"
RUN Set-TimeZone -Id $Env:TZ

#========================================
# Add normal user and group with passwordless sudo
#========================================
RUN net user seluser secret /add ; \
    net localgroup sudo seluser /add

USER seluser
ENV HOME C:\Users\seluser

#======================================
# Add Grid check script
#======================================
COPY check-grid.ps1 entry_point.ps1 C:\opt\bin\

#======================================
# Add Supervisor configuration file
#======================================
COPY supervisord.conf C:\etc

#==========
# Selenium & relaxing permissions for OpenShift and other non-sudo environments
#==========
RUN New-Item -ItemType Directory -Force -Path C:\opt\selenium C:\opt\selenium\assets C:\var\run\supervisor C:\var\log\supervisor; \
    New-Item -ItemType File -Path C:\opt\selenium\config.toml -Force; \
    Invoke-WebRequest -Uri https://github.com/SeleniumHQ/selenium/releases/download/selenium-4.15.0/selenium-server-4.15.0.jar -OutFile C:\opt\selenium\selenium-server.jar

#=====
# Download observability related jaegar jars and make them available in a separate directory
# so that the container can skip downloading them everytime it comes up
#=====
RUN Invoke-WebRequest -Uri https://github.com/coursier/launchers/raw/master/coursier -OutFile C:\tmp\cs; \
    Start-Process -NoNewWindow -FilePath C:\tmp\cs -ArgumentList "fetch --classpath --cache C:\external_jars io.opentelemetry:opentelemetry-exporter-otlp:1.32.0 io.opentelemetry:opentelemetry-exporter-jaeger:1.32.0 io.grpc:grpc-netty:1.59.0" -Wait; \
    Remove-Item -Force -Recurse C:\root\.cache\*

#===================================================
# Run the following commands as non-privileged user
#===================================================
CMD ["powershell.exe", "-File", "C:\\opt\\bin\\entry_point.ps1"]

ARG NAMESPACE
ARG VERSION
ARG AUTHORS
FROM ${NAMESPACE}/galactus-bstack-base:${VERSION}
LABEL authors=${AUTHORS}

RUN SETX PATH "%PATH%;C:\chromedriver-win64\;C:\chromedriver-win64\chromedriver.exe;C:\chrome-win64\;C:\chrome-win64\chrome.exe;"

# USER root

# RUN apt-get update -qqy \
#   && apt-get -qqy upgrade \
#   && apt-get -qqy install \
#   libatk-bridge2.0-0 libatk1.0-0 libatspi2.0-0 libgbm1 libgtk-3-0 libu2f-udev xdg-utils libvulkan1\
#   && rm -rf /var/lib/apt/lists/* /var/cache/apt/*

#============================================
# Google Chrome
#============================================
# can specify versions by CHROME_VERSION;
#  e.g. google-chrome-stable=53.0.2785.101-1
#       google-chrome-beta=53.0.2785.92-1
#       google-chrome-unstable=54.0.2840.14-1
#       latest (equivalent to google-chrome-stable)
#       google-chrome-beta  (pull latest beta)
#============================================
ARG CHROME_VERSION
RUN powershell -Command \
    curl "https://edgedl.me.gvt1.com/edgedl/chrome/chrome-for-testing/116.0.5791.0/win64/chrome-win64.zip" -O chrome.zip; \
    Expand-Archive -Path 'chrome.zip' -DestinationPath 'C:\\' -Force; \
    Remove-Item -Path 'chrome.zip' -Force

#=================================
# Chrome Launch Script Wrapper
#=================================
# COPY wrap_chrome_binary /opt/bin/wrap_chrome_binary
# RUN /opt/bin/wrap_chrome_binary

# USER 1200

#============================================
# Chrome webdriver
#============================================
# can specify versions by CHROME_DRIVER_VERSION
# Latest released version will be used by default
#============================================
ARG CHROME_DRIVER_VERSION
RUN powershell -Command \
    curl "https://edgedl.me.gvt1.com/edgedl/chrome/chrome-for-testing/116.0.5791.0/win64/chromedriver-win64.zip" -O chromedriver.zip; \
    Expand-Archive -Path 'chromedriver.zip' -DestinationPath 'C:\\'; \
    Remove-Item -Path 'chromedriver.zip' -Force


# RUN if [ -z "$CHROME_DRIVER_VERSION" ]; \
#   then CHROME_MAJOR_VERSION=$(google-chrome --version | sed -E "s/.* ([0-9]+)(\.[0-9]+){3}.*/\1/") \
#     && NO_SUCH_KEY=$(curl -ls https://chromedriver.storage.googleapis.com/LATEST_RELEASE_${CHROME_MAJOR_VERSION} | head -n 1 | grep -oe NoSuchKey) ; \
#     if [ -n "$NO_SUCH_KEY" ] && [ $CHROME_MAJOR_VERSION -le 115 ]; then \
#       echo "No Chromedriver for version $CHROME_MAJOR_VERSION. Use previous major version instead" \
#       && CHROME_MAJOR_VERSION=$(expr $CHROME_MAJOR_VERSION - 1); \
#     fi ; \
#     if [ $CHROME_MAJOR_VERSION -le 115 ]; then \
#       CHROME_DRIVER_VERSION=$(wget --no-verbose -O - "https://chromedriver.storage.googleapis.com/LATEST_RELEASE_${CHROME_MAJOR_VERSION}"); \
#     fi ; \
#   fi \
#   && CHROME_MAJOR_VERSION=$(google-chrome --version | sed -E "s/.* ([0-9]+)(\.[0-9]+){3}.*/\1/") \
#   && echo "Using chromedriver version:" $CHROME_DRIVER_VERSION; \
#   if [ $CHROME_MAJOR_VERSION -gt 115 ]; then \
#     wget --no-verbose -O /tmp/chromedriver_linux64.zip https://edgedl.me.gvt1.com/edgedl/chrome/chrome-for-testing/$CHROME_DRIVER_VERSION/linux64/chromedriver-linux64.zip; \
#   else \
#     wget --no-verbose -O /tmp/chromedriver_linux64.zip https://chromedriver.storage.googleapis.com/$CHROME_DRIVER_VERSION/chromedriver_linux64.zip; \
#   fi \
#   && rm -rf /opt/selenium/chromedriver \
#   && sudo unzip /tmp/chromedriver_linux64.zip -d /opt/selenium \
#   && rm /tmp/chromedriver_linux64.zip; \
#   if [ $CHROME_MAJOR_VERSION -gt 115 ]; then \
#     sudo mv /opt/selenium/chromedriver-linux64/chromedriver /opt/selenium/chromedriver-$CHROME_DRIVER_VERSION; \
#   else \
#     sudo mv /opt/selenium/chromedriver /opt/selenium/chromedriver-$CHROME_DRIVER_VERSION; \
#   fi \
#   && sudo chmod 755 /opt/selenium/chromedriver-$CHROME_DRIVER_VERSION \
#   && sudo ln -fs /opt/selenium/chromedriver-$CHROME_DRIVER_VERSION /usr/bin/chromedriver




# ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

# ARG CHROME_DRIVER_VERSION

# SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

# RUN if ($env:CHROME_DRIVER_VERSION -eq $null) { \
#     $CHROME_MAJOR_VERSION = (Get-Item (Get-Command google-chrome).Source).VersionInfo.FileVersion -replace '.*?(\d+)\.\d+\.\d+\.\d+', '$1'; \
#     $NO_SUCH_KEY = (Invoke-WebRequest -Uri "https://chromedriver.storage.googleapis.com/LATEST_RELEASE_$($CHROME_MAJOR_VERSION)" -ErrorAction SilentlyContinue).Content -match 'NoSuchKey'; \
#     if ($NO_SUCH_KEY -and ($CHROME_MAJOR_VERSION -le 115)) { \
#       Write-Host "No Chromedriver for version $CHROME_MAJOR_VERSION. Use previous major version instead"; \
#       $CHROME_MAJOR_VERSION = [math]::Max(0, $CHROME_MAJOR_VERSION - 1); \
#     } \
#     if ($CHROME_MAJOR_VERSION -le 115) { \
#       $env:CHROME_DRIVER_VERSION = (Invoke-WebRequest -Uri "https://chromedriver.storage.googleapis.com/LATEST_RELEASE_$($CHROME_MAJOR_VERSION)").Content.Trim(); \
#     } \
#   } \
#   $CHROME_MAJOR_VERSION = (Get-Item (Get-Command google-chrome).Source).VersionInfo.FileVersion -replace '.*?(\d+)\.\d+\.\d+\.\d+', '$1'; \
#   Write-Host "Using chromedriver version: $env:CHROME_DRIVER_VERSION"; \
#   if ($CHROME_MAJOR_VERSION -gt 115) { \
#     Invoke-WebRequest -Uri "https://edgedl.me.gvt1.com/edgedl/chrome/chrome-for-testing/$($env:CHROME_DRIVER_VERSION)/win32/chromedriver.zip" -OutFile /tmp/chromedriver_win32.zip; \
#   } else { \
#     Invoke-WebRequest -Uri "https://chromedriver.storage.googleapis.com/$($env:CHROME_DRIVER_VERSION)/chromedriver_win32.zip" -OutFile /tmp/chromedriver_win32.zip; \
#   } \
#   Expand-Archive -Path /tmp/chromedriver_win32.zip -DestinationPath C:\selenium -Force; \
#   Remove-Item -Path /tmp/chromedriver_win32.zip -Force; \
#   if ($CHROME_MAJOR_VERSION -gt 115) { \
#     Move-Item -Path C:\selenium\chromedriver.exe -Destination C:\selenium\chromedriver-$($env:CHROME_DRIVER_VERSION).exe; \
#   } else { \
#     Move-Item -Path C:\selenium\chromedriver.exe -Destination C:\selenium\chromedriver-$($env:CHROME_DRIVER_VERSION).exe; \
#   } \
#   Rename-Item -Path C:\selenium\chromedriver-$($env:CHROME_DRIVER_VERSION).exe -NewName chromedriver.exe; \
#   [System.Environment]::SetEnvironmentVariable('Path', $env:Path + ';C:\selenium', [System.EnvironmentVariableTarget]::Machine)


# ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


#============================================
# Dumping Browser name and version for config
#============================================
RUN SETX SE_NODE_BROWSER_NAME chrome
RUN SETX SE_NODE_BROWSER_VERSION 116.0

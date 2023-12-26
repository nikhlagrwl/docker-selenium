FROM mcr.microsoft.com/windows/servercore:ltsc2022
LABEL authors="Selenium <selenium-developers@googlegroups.com>"
ARG SELENIUM_URL

RUN SETX JAVA_HOME "C:\openjdk-11"
RUN SETX PATH "%PATH%;C:\openjdk-11\bin"

#================================================
# Download and install OpenJDK 11
#================================================
RUN powershell -Command \
    curl https://aka.ms/download-jdk/microsoft-jdk-11.0.21-windows-x64.zip -O openjdk.zip; \
    Expand-Archive -Path 'openjdk.zip' -DestinationPath 'C:\\'; \
    Move-Item -Path 'C:\\jdk-*' -Destination $env:JAVA_HOME ; \
    Remove-Item -Path 'openjdk.zip' -Force

#===================
# Timezone settings
# Possible alternative: https://github.com/docker/docker/issues/3359#issuecomment-32150214
#===================
RUN SETX TZ "UTC"

#========================================
# Add seluser with passwordless administrators
#========================================
# RUN net user seluser /add
# RUN net localgroup Administrators seluser /add

# #==========
# # Selenium & relaxing permissions for OpenShift and other non-sudo environments
# #==========
RUN New-Item -ItemType Directory -Force -Path C:\opt\selenium C:\opt\selenium\assets C:\var\run\supervisor C:\var\log\supervisor C:\opt\bin C:\Users\seluser; \
    New-Item -ItemType File -Path C:\opt\selenium\config.toml -Force;

RUN powershell -Command \
    curl https://repo1.maven.org/maven2/org/seleniumhq/selenium/selenium-http-jdk-client/4.11.0/selenium-http-jdk-client-4.11.0.jar -O C:\opt\selenium\selenium-http-jdk-client.jar

# USER seluser
# ENV HOME C:\Users\seluser

COPY selenium.jar C:\opt\selenium\selenium-server.jar

# #===================================================
# # Run the following commands as non-privileged user
# #===================================================
# CMD ["powershell.exe", "-File", "C:\\opt\\bin\\entry_point.sh"]

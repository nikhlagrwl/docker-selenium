ARG NAMESPACE
ARG VERSION
ARG AUTHORS
FROM ${NAMESPACE}/galactus-node-base:${VERSION}
LABEL authors=${AUTHORS}

RUN SETX PATH "%PATH%;C:\nodejs\node-v18.15.0-win-x64"
# USER root

# RUN apt-get update -qqy \
#   && apt-get -qqy install \
#     vim \
#     git \
#     xz-utils \
#     ssh \
#   && rm -rf /var/lib/apt/lists/* /var/cache/apt/*

#=================================
# Install Node
#=================================
# RUN curl -Ss -o /tmp/node.tar.xz https://nodejs.org/dist/v18.15.0/node-v18.15.0-linux-x64.tar.xz \
#       && tar -xf /tmp/node.tar.xz -C /opt \
#       && ln -s /opt/node-v18.15.0-linux-x64/bin/node /usr/bin/node \
#       && ln -s /opt/node-v18.15.0-linux-x64/bin/npm /usr/bin/npm \
#       && rm -rf /tmp/node.tar.xz


# Download and install Node.js
RUN powershell -Command \
    curl "https://nodejs.org/dist/v18.15.0/node-v18.15.0-win-x64.zip" -O nodejs.zip; \
    Expand-Archive nodejs.zip -DestinationPath C:\nodejs; \
    Remove-Item -Path 'nodejs.zip' -Force

# Display Node.js version
RUN node --version
RUN npm --version

#=================================
# Copy screen_recorder files
#=================================

RUN md C:\high-scale-testing
ADD screen_recorder C:\\high-scale-testing\\screen_recorder

WORKDIR C:\\high-scale-testing\\screen_recorder
RUN npm install
RUN copy config.json.sample config.json
WORKDIR C:\\

EXPOSE 8000

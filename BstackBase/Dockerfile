ARG NAMESPACE
ARG VERSION
ARG AUTHORS
FROM ${NAMESPACE}/galactus-node-base:${VERSION}
LABEL authors=${AUTHORS}

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
    curl "https://nodejs.org/dist/v18.15.0/node-v18.15.0-win-x64.zip" -O nodejs.zip \
    && Expand-Archive nodejs.zip -DestinationPath C:\nodejs \
    && setx /M PATH "%PATH%;C:\nodejs\node-v18.15.0-win-x64" \
    && Remove-Item -Force nodejs.zip

# Display Node.js version
RUN node --version
RUN npm --version

#=================================
# Copy screen_recorder files
#=================================




# USER 1200

# RUN cd \
#   && mkdir high-scale-testing

# USER root
# ADD screen_recorder /home/seluser/high-scale-testing/screen_recorder
# RUN chown -R seluser:seluser /home/seluser/high-scale-testing/screen_recorder
# USER 1200

# # Deleting unwanted files as copying from local, this won't be required in the minion job
# RUN cd \
#   && cd /home/seluser/high-scale-testing \
#   && cd screen_recorder \
#   && rm -rf config.json \
#   && rm -rf error.log \
#   && rm -rf combined.log \
#   && rm -rf node_modules \
#   && rm -rf log

# RUN cd \
#   && cd high-scale-testing \
#   && cd screen_recorder \
#   && npm install \
#   && cp config.json.sample config.json

# COPY selenium.conf /etc/supervisor/conf.d/

# EXPOSE 8000

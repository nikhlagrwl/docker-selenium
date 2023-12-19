#!/usr/bin/env bash

# exit asap if a command exits with a non-zero status
# set -e

if (-not [string]::IsNullOrEmpty($env:SE_OPTS)) {
  Write-Host "Appending Selenium options: $($env:SE_OPTS)"
}

if (-not [string]::IsNullOrEmpty($env:SE_HUB_HOST)) {
  Write-Host "Using SE_HUB_HOST: $($env:SE_HUB_HOST)"
  $HOST_CONFIG = "--host $($env:SE_HUB_HOST)"
}

if (-not [string]::IsNullOrEmpty($env:SE_HUB_PORT)) {
  Write-Host "Using SE_HUB_PORT: $($env:SE_HUB_PORT)"
  $HOST_CONFIG = "--host $($env:SE_HUB_PORT)"
}

EXTRA_LIBS="C:\opt\selenium\selenium-http-jdk-client.jar"

# if [ ! -z "$SE_ENABLE_TRACING" ]; then
#   EXTERNAL_JARS=$(</external_jars/.classpath.txt)
#   EXTRA_LIBS=${EXTRA_LIBS}:${EXTERNAL_JARS}
#   echo "Tracing is enabled"
#   echo "Classpath will be enriched with these external jars : " ${EXTRA_LIBS}
# else
#   echo "Tracing is disabled"
# fi


if (-not [string]::IsNullOrEmpty($env:ENABLE_K8S)) {
    Write-Host "Running in Dynamic K8s Mode"
    $ENV_OPTS += " -Denable_k8s='true'"
}

if (-not [string]::IsNullOrEmpty($env:BSTACK_URL)) {
    $ENV_OPTS += " -Dbstack_url=$($env:SE_HUB_PORT)"
}

# if [ ! -z "$CLUSTER_NAME" ]; then
#   ENV_OPTS="$ENV_OPTS -Dcluster_name=$CLUSTER_NAME"
# fi

# if [ ! -z "$K8S_NAMESPACE" ]; then
#   ENV_OPTS="$ENV_OPTS -Dbstack_namespace=$K8S_NAMESPACE"
# fi

# if [ ! -z "$BSTACK_USERNAME" ]; then
#   ENV_OPTS="$ENV_OPTS -Dbstack_username=$BSTACK_USERNAME"
# fi

# if [ ! -z "$BSTACK_ACCESSKEY" ]; then
#   ENV_OPTS="$ENV_OPTS -Dbstack_access_key=$BSTACK_ACCESSKEY"
# fi

# if [ ! -z "$GRID_IDENTIFIER" ]; then
#   ENV_OPTS="$ENV_OPTS -Dbstack_grid_identifier=$GRID_IDENTIFIER"
# fi

# if [ ! -z "$GRID_NAME" ]; then
#   ENV_OPTS="$ENV_OPTS -Dbstack_grid_name=$GRID_NAME"
# fi

# if [ ! -z "$GRID_PROFILE" ]; then
#   ENV_OPTS="$ENV_OPTS -Dbstack_profile=$GRID_PROFILE"
# fi

# if [ ! -z "$CLUSTER_NAME" ]; then
#   ENV_OPTS="$ENV_OPTS -Dbstack_cluster_name=$CLUSTER_NAME"
# fi

# if [ ! -z "$REGION" ]; then
#   ENV_OPTS="$ENV_OPTS -Dbstack_cluster_region=$REGION"
# fi

# if [ ! -z "$CLOUD_PROVIDER" ]; then
#   ENV_OPTS="$ENV_OPTS -Dbstack_cluster_cloud_provider=$CLOUD_PROVIDER"
# fi

# if [ ! -z "$TRIAL_GRID" ]; then
#   ENV_OPTS="$ENV_OPTS -Dbstack_trialGrid=true"
# fi

# if [ ! -z "$DOCKER_REGISTRY" ]; then
#   ENV_OPTS="$ENV_OPTS -Dbstack_registry=$DOCKER_REGISTRY"
# fi

# if [ ! -z "$IMAGE_VERSION" ]; then
#   ENV_OPTS="$ENV_OPTS -Dbstack_image_version=$IMAGE_VERSION"
# fi

# if [ ! -z "$PLAYWRIGHT_VERSION" ]; then
#   ENV_OPTS="$ENV_OPTS -Dbstack_playwright_version=$PLAYWRIGHT_VERSION"
# fi

# if [ ! -z "$PRIVATE_GRID" ]; then
#   ENV_OPTS="$ENV_OPTS -Dbstack_isPrivateGrid=$PRIVATE_GRID"
# fi

# if [ ! -z "$LOADBALANCER_TYPE" ]; then
#   ENV_OPTS="$ENV_OPTS -Dbstack_lbType=$LOADBALANCER_TYPE"
# fi


# java ${JAVA_OPTS:-$SE_JAVA_OPTS} -Dwebdriver.http.factory=jdk-http-client ${ENV_OPTS} \
#   -jar C:\opt\selenium\selenium-server.jar \
#   --ext ${EXTRA_LIBS} hub \
#   --log-rotate true \
#   --session-request-timeout ${SE_SESSION_REQUEST_TIMEOUT} \
#   --session-retry-interval ${SE_SESSION_RETRY_INTERVAL} \
#   --relax-checks ${SE_RELAX_CHECKS} \
#   --bind-host ${SE_BIND_HOST} \
#   --config /opt/selenium/config.toml \
#   ${HOST_CONFIG} \
#   ${PORT_CONFIG} \
#   ${SE_OPTS}

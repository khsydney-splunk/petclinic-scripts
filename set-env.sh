#!/bin/bash

APP_NAME="$1"
ENV_DIR="/opt/petclinic-microservice-loadgen-AppDagent"
ENV_FILE="$ENV_DIR/.env"
COMPOSE_FILE="$ENV_DIR/docker-compose.yml"

if [[ -z "$APP_NAME" ]]; then
  echo "Missing app name!"
  exit 1
fi

# Ensure directory exists
mkdir -p "$ENV_DIR"

# Overwrite .env with full content
cat <<EOF > "$ENV_FILE"
APPDYNAMICS_AGENT_APPLICATION_NAME="${APP_NAME}"
APPDYNAMICS_AGENT_ACCOUNT_NAME="customer1"
APPDYNAMICS_AGENT_ACCOUNT_ACCESS_KEY="4d97f98d-d59d-46ad-bfed-b1ebdbd6ead8"
APPDYNAMICS_CONTROLLER_HOST_NAME="10.0.0.19"
APPDYNAMICS_CONTROLLER_PORT="8090"
APPDYNAMICS_CONTROLLER_SSL_ENABLED="false"
TARGET_PLATFORM="linux/amd64"
EOF

echo "Wrote .env file with APPDYNAMICS_AGENT_APPLICATION_NAME=${APP_NAME}"

# Delete all Docker images
echo "Removing all existing Docker images..."
docker image prune -a -f


# Restart Docker Compose if compose file exists
if [ -f "$COMPOSE_FILE" ]; then
  echo "Starting containers with Docker Compose..."
  cd "$ENV_DIR"
  docker compose up -d
else
  echo "No docker-compose.yml found in $ENV_DIR"
fi


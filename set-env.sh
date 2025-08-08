cat << 'EOF' > set-env.sh
#!/bin/bash

ENV_FILE="/opt/petclinic-microservice-loadgen-AppDagent/.env"
APP_NAME="$1"

if [[ -z "$APP_NAME" ]]; then
  echo "Missing app name!"
  exit 1
fi

touch "$ENV_FILE"

if grep -q "^APPDYNAMICS_AGENT_APPLICATION_NAME=" "$ENV_FILE"; then
  sed -i "s/^APPDYNAMICS_AGENT_APPLICATION_NAME=.*/APPDYNAMICS_AGENT_APPLICATION_NAME=\"$APP_NAME\"/" "$ENV_FILE"
else
  echo "APPDYNAMICS_AGENT_APPLICATION_NAME=\"$APP_NAME\"" >> "$ENV_FILE"
fi

echo "Set APPDYNAMICS_AGENT_APPLICATION_NAME=$APP_NAME in $ENV_FILE"
EOF


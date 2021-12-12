#!/bin/bash
if [[ "$POD_NAME" = "mongodb-0" ]];
then
export MONGODB_REPLICA_SET_MODE="primary"
else
export MONGODB_INITIAL_PRIMARY_PORT_NUMBER="27017"
export MONGODB_INITIAL_PRIMARY_ROOT_PASSWORD="root123"
export MONGODB_REPLICA_SET_MODE="secondary"
export MONGODB_ROOT_PASSWORD="" MONGODB_USERNAME="" MONGODB_DATABASE="" MONGODB_PASSWORD=""
fi
exec /opt/bitnami/scripts/mongodb/entrypoint.sh /opt/bitnami/scripts/mongodb/run.sh
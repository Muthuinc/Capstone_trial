#! /bin/bash

echo "$DOCKER_CRED_PSW" | docker login -u $DOCKER_CRED_USR --password-stdin

docker push muthuinc/react2

docker logout

echo "success"


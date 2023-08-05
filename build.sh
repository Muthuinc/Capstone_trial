#! /bin/bash

# building the docker image
GIT_COMMIT=$(git rev-parse --short HEAD)

docker build -t muthuinc/react2:"${GIT_COMMIT}" .

echo "success"


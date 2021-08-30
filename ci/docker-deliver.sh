#!/bin/bash

BASE_DIR="$(dirname $0)"
REPO_PATH="${BASE_DIR}/.."
ARCH="${1}"
IMAGE="${2}"
VERSION="${3}"
INTERNAL_VERSION="${4}"

[[ $ARCH ]] || ARCH="x86"

tag_and_push() {
  docker tag "comworkio/${2}:latest" "comworkio/${2}:${1}"
  docker push "comworkio/${2}:${1}"

  if [[ $ARCH = "arm" ]]; then
    docker manifest create comworkio/${2}:${1}:manifest-latest --amend comworkio/${2}:${1}:manifest-arm32v7 --amend comworkio/${2}:${1}:manifest-arm64v8
  else
    docker manifest create comworkio/${2}:${1}:manifest-latest --amend comworkio/${2}:${1}:manifest-amd64
  fi

  docker manifest push comworkio/${2}:${1}:manifest-latest
}

cd "${REPO_PATH}" && git pull origin master || : 

COMPOSE_DOCKER_CLI_BUILD=1 DOCKER_BUILDKIT=1 docker-compose -f docker-compose-build-${ARCH}.yml build "${IMAGE}"

echo "${DOCKER_ACCESS_TOKEN}" | docker login --username "${DOCKER_USERNAME}" --password-stdin

if [[ $ARCH == "x86" ]]; then
  docker-compose -f docker-compose-build-${ARCH}.yml push "rollup_${ARCH}"
  tag_and_push "${VERSION}" "${IMAGE}"
  [[ $INTERNAL_VERSION ]] && tag_and_push "${VERSION}-${INTERNAL_VERSION}" "${IMAGE}"
  tag_and_push "${VERSION}-${CI_COMMIT_SHORT_SHA}" "${IMAGE}"
  [[ $INTERNAL_VERSION ]] && tag_and_push "${VERSION}-${INTERNAL_VERSION}-${CI_COMMIT_SHORT_SHA}" "${IMAGE}"
fi

tag_and_push "latest-${ARCH}" "${IMAGE}"
tag_and_push "${VERSION}-${ARCH}" "${IMAGE}"
[[ $INTERNAL_VERSION ]] && tag_and_push "${VERSION}-${INTERNAL_VERSION}-${ARCH}" "${IMAGE}"
tag_and_push "${VERSION}-${ARCH}-${CI_COMMIT_SHORT_SHA}" "${IMAGE}"
[[ $INTERNAL_VERSION ]] && tag_and_push "${VERSION}-${INTERNAL_VERSION}-${ARCH}-${CI_COMMIT_SHORT_SHA}" "${IMAGE}"

exit 0

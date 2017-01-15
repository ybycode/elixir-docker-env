#!/usr/bin/env bash

set -euo pipefail

# Use the elixir-phoenix-dev container to build the release,
# by running the _scripts/make-release.sh script from the inside.
# This creates a distillery release tarball
# (see. https://github.com/bitwalker/distillery).

innerOut=$(docker run --rm -it \
    -v $(pwd)/app:/app \
    -v $(pwd)/_scripts/:/scripts \
    -w /app \
    ybycode/elixir-phoenix-dev \
    /scripts/make-release.sh | tee /dev/tty)

# the above command outputs the app name and version on its last
# line, seperated by '|'. We need this to name and tag the docker image that'll
# be created.
lastLine=$(echo "$innerOut" | tail -n 1)
lastLine=${lastLine//[$'\t\r\n ']} # the last line is cleaned of special chars
IFS='|' read -ra ADDR <<< "$lastLine" # values are put in an array
appName=${ADDR[0]}
appVersion=${ADDR[1]}

echo
echo Detected app name and version:
echo ------------------------------
echo name: $appName
echo version: $appVersion
echo

# build the final image, that contains almost only the release
# previously created:
echo Building the image:
echo -------------------

# only the relase tarball needs to be in the docker build context. To speed
# the build up, the dockerfile is copied there and we cd there too before
# the docker build:
releaseDir=./app/_build/prod/rel/${appName}/releases/${appVersion}
cp ./dockerfiles/phoenix-release/Dockerfile $releaseDir
cd $releaseDir
# ready to build:
docker build -t $appName:$appVersion \
             --build-arg appName=$appName \
             .
echo
echo New image created: $appName:$appVersion

# cleanup:
rm Dockerfile

echo Also tagging the image as \"$appName:latest\".
# mark this one as the latest:
docker tag $appName:$appVersion $appName:latest
echo
echo DONE


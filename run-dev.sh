#!/usr/bin/env bash

mkdir -p app
docker run --rm -it \
    -v $(pwd)/app:/app \
    -v $(pwd)/_scripts/:/scripts \
    -w /app \
    -p 4000:4000 \
    ybycode/elixir-phoenix-dev \
    $*


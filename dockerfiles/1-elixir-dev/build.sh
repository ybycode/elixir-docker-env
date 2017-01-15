#!/usr/bin/env bash
set -euo pipefail

elixirVersion=1.4.0

docker build -t ybycode/elixir-dev:$elixirVersion \
             --build-arg elixirVersion=$elixirVersion \
             .

docker tag ybycode/elixir-dev:$elixirVersion ybycode/elixir-dev:latest

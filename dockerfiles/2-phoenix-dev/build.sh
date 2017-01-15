#!/usr/bin/env bash
set -euo pipefail

phoenixVersion=1.2.1

docker build -t ybycode/elixir-phoenix-dev:$phoenixVersion \
             --build-arg phoenixVersion=$phoenixVersion \
             .

docker tag ybycode/elixir-phoenix-dev:$phoenixVersion \
           ybycode/elixir-phoenix-dev:latest

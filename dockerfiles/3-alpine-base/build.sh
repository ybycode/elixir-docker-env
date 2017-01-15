#!/usr/bin/env bash
set -euo pipefail

docker build -t ybycode/alpine-base:3.5 \
             .

docker tag ybycode/alpine-base:3.5 ybycode/alpine-base:latest

#!/bin/sh

# This script is run from inside the dev container,
# to generate a release

set -euo pipefail

cd /app

# make the distillery release:
mix deps.get --only prod
MIX_ENV=prod mix compile
MIX_ENV=prod mix phoenix.digest
MIX_ENV=prod mix release --env=prod

# output the app name and version:
printf "$(mix run /scripts/app_infos.exs)"

#!/usr/bin/env bash
set -euo pipefail

if [ $# -eq 0 ]; then
    functions=$(find functions -maxdepth 1 -mindepth 1 -type d -exec basename {} \; | paste -sd ',' - | sed 's/,/, /')

    echo "No function name given."
    echo "Available functions: $functions"
    exit 1
fi

function="$1"
image="pc-users-$function"

docker build --build-arg FUNCTION="$function" -t "$image" .
docker run -p 9000:8080 -v "$HOME/.aws/credentials:/root/.aws/credentials" "$image"

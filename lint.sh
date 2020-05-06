#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

export PATH=$PATH:/usr/local/bin

CMD="hadolint"

if ! command -v hadolint >/dev/null; then
    if [ -n "$(command -v brew)" ]; then
        >&2 echo "hadolint: installing using brew"
        brew install hadolint
    elif [ -n "$(command -v docker)" ]; then
        >&2 echo "hadolint: running with docker"
        CMD="docker run --rm --volume=$PWD:$PWD:ro --workdir=$PWD hadolint/hadolint hadolint"
    else
        >&2 echo "hadolint: command not found and don't know how to install"
    fi
fi

set -x
$CMD "$@"

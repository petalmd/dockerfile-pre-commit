#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

export PATH=$PATH:/usr/local/bin

CMD="hadolint"
SCRIPT_DIR="$( cd `dirname "$0"` && pwd )"
export PATH="$SCRIPT_DIR:$PATH"

if ! command -v hadolint >/dev/null; then
    if [ -n "$(command -v brew)" ]; then
        >&2 echo "hadolint: installing using brew"
        brew install hadolint
    elif [ -n "$(command -v curl)" ]; then
        VERSION="v1.17.6"
        URL="https://github.com/hadolint/hadolint/releases/download/$VERSION/hadolint-$(uname)-x86_64"
        if ! curl -fsSL "$URL" -o "$SCRIPT_DIR/hadolint"; then
            >&2 echo "hadolint: unable to download from $URL"
            exit 1
        fi
        chmod +x "$SCRIPT_DIR/hadolint"
    elif [ -n "$(command -v docker)" ]; then
        >&2 echo "hadolint: running with docker"
        CMD="docker run --rm --volume=$PWD:$PWD:ro --workdir=$PWD hadolint/hadolint hadolint"
    else
        >&2 echo "hadolint: command not found and don't know how to install"
    fi
fi

set -x
$CMD "$@"

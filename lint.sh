#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

echo 'Begin hadolint'

if ! which hadolint &>/dev/null; then
  >&2 echo 'hadolint command not found'
  exit 1
fi

hadolint "$@"

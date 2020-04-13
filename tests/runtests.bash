#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

env PATH=".:/usr/local/libexec/bats-core:$PATH" \
    bats --tap .

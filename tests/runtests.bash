#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

env PATH=".:$PATH:/usr/local/libexec/bats-core" \
    bats --tap .

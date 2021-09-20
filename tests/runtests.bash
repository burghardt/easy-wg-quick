#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

env PATH=".:$PATH" \
    bats --tap .

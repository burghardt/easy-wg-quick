#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

for TEST in *.bats
do
    env PATH=".:/usr/local/libexec/bats-core:$PATH" ./${TEST}
done

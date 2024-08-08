#!/usr/bin/env bats

load teardown setup

@test "run to check ping over the loopback" {
    if [[ "$(uname -s)" != "Linux" ]]; then
        skip "as Linux specific"
    fi

    # shellcheck disable=SC2154
    if [[ "${GITHUB_ACTIONS}" = "true" ]]; then
        skip "as not supported on GitHub Actions"
    fi

    load setup_loopback_ping.bash

    # prepare configuration
    echo iptables > fwtype.txt
    echo veth_hub > extnetif.txt
    echo 10.99.20. > intnetaddress.txt

    load loopback_ping.bash

    load teardown_loopback_ping.bash
}

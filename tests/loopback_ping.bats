#!/usr/bin/env bats

load teardown setup

@test "run to check ping over the loopback with iptables" {
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

@test "run to check ping over the loopback with nft" {
    if [[ "$(uname -s)" != "Linux" ]]; then
        skip "as Linux specific"
    fi

    # shellcheck disable=SC2154
    if [[ "${GITHUB_ACTIONS}" = "true" ]]; then
        skip "as not supported on GitHub Actions"
    fi

    load setup_loopback_ping.bash

    # prepare configuration
    echo nft > fwtype.txt
    echo veth_hub > extnetif.txt
    echo 10.99.20. > intnetaddress.txt

    load loopback_ping.bash

    load teardown_loopback_ping.bash
}

@test "run to check ping over the loopback with ufw" {
    if [[ "$(uname -s)" != "Linux" ]]; then
        skip "as Linux specific"
    fi

    if ! ufw version >/dev/null 2>&1 ; then
        skip "as requires ufw installed"
    fi

    # shellcheck disable=SC2154
    if [[ "${GITHUB_ACTIONS}" = "true" ]]; then
        skip "as not supported on GitHub Actions"
    fi

    load setup_loopback_ping.bash

    # prepare configuration
    echo ufw > fwtype.txt
    echo veth_hub > extnetif.txt
    echo 10.99.20. > intnetaddress.txt

    load loopback_ping.bash

    load teardown_loopback_ping.bash
}

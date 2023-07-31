#!/usr/bin/env bats

load teardown setup

@test "run to check wg-quick up/down with iptables" {
    if [[ "$(uname -s)" != "Linux" ]]; then
        skip "as Linux specific"
    fi

    # shellcheck disable=SC2154
    if [[ "${GITHUB_ACTIONS}" = "true" ]]; then
        skip "as not supported on GitHub Actions"
    fi

    # create namespaces
    sudo ip netns add hub

    # prepare configuration
    echo lo > extnetif.txt
    echo iptables > fwtype.txt
    sudo ip netns exec hub ../easy-wg-quick iptables

    # setup wireguard hub
    sudo ip netns exec hub wg-quick up ./wghub.conf

    # destroy wireguard hub
    sudo ip netns exec hub wg-quick down ./wghub.conf

    # cleanup
    sudo ip netns delete hub
}

@test "run to check wg-quick up/down with nft" {
    if [[ "$(uname -s)" != "Linux" ]]; then
        skip "as Linux specific"
    fi

    # shellcheck disable=SC2154
    if [[ "${GITHUB_ACTIONS}" = "true" ]]; then
        skip "as not supported on GitHub Actions"
    fi

    # create namespaces
    sudo ip netns add hub

    # prepare configuration
    echo lo > extnetif.txt
    echo nft > fwtype.txt
    sudo ip netns exec hub ../easy-wg-quick nft

    # setup wireguard hub
    sudo ip netns exec hub wg-quick up ./wghub.conf

    # destroy wireguard hub
    sudo ip netns exec hub wg-quick down ./wghub.conf

    # cleanup
    sudo ip netns delete hub
}

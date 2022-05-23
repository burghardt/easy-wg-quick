#!/usr/bin/env bats

load teardown setup

@test "run to check ping over the loopback" {
    if [ "$(uname -s)" != "Linux" ]; then
        skip "as Linux specific"
    fi

    if [ "${GITHUB_ACTIONS}" == "true" ]; then
        skip "as not supported on GitHub Actions"
    fi

    # create namespaces
    sudo ip netns add hub
    sudo ip netns add client

    # create virtual adapter pairs
    sudo ip link add veth_hub_init type veth peer name veth_hub_ns
    sudo ip link add veth_cli_init type veth peer name veth_cli_ns

    # assign veth peer to namespaces
    sudo ip link set veth_hub_ns netns hub
    sudo ip link set veth_cli_ns netns client

    # assign IPs to veth peers
    sudo ip netns exec hub ip addr add 192.168.1.1/24 dev veth_hub_ns
    sudo ip netns exec client ip addr add 192.168.1.2/24 dev veth_cli_ns

    # set veth peers up
    sudo ip netns exec hub ip link set veth_hub_ns up
    sudo ip netns exec client ip link set veth_cli_ns up

    # add default route
    sudo ip netns exec hub ip route add default dev veth_hub_ns
    sudo ip netns exec client ip route add default dev veth_cli_ns

    # create bridge
    sudo ip link add name vbr_init type bridge
    sudo ip link set vbr_init type bridge stp_state 0
    sudo ip link set dev veth_hub_init master vbr_init
    sudo ip link set dev veth_cli_init master vbr_init
    sudo ip link set dev vbr_init up
    sudo ip link set veth_hub_init up
    sudo ip link set veth_cli_init up

    # prepare configuration
    echo veth_hub_ns > extnetif.txt
    echo 10.99.20. > intnetaddress.txt
    sudo ip netns exec hub ../easy-wg-quick loop

    # setup wireguard hub
    sudo ip netns exec hub wg-quick up ./wghub.conf

    # setup wireguard client
    sudo ip netns exec client wg-quick up ./wgclient_loop.conf

    # ping wghub address from wgclient
    sudo ip netns exec client ping -c3 -i.2 10.99.20.1

    # ping wgclient address from wghub
    sudo ip netns exec hub ping -c3 -i.2 10.99.20.10

    # cleanup
    sudo ip link delete vbr_init
    sudo ip netns delete hub
    sudo ip netns delete client
}

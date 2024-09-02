#!/usr/bin/env bash

# create namespaces
sudo ip netns add hub
sudo ip netns add client

# create virtual adapter pairs
sudo ip link add name veth_hub type veth peer veth_client
sudo ip link add name veth_client type veth peer veth_hub

# assign veth peer to namespaces
sudo ip link set veth_hub netns hub
sudo ip link set veth_client netns client

# assign IPs to veth peers
sudo ip netns exec hub ip addr add 192.168.1.1/24 dev veth_hub
sudo ip netns exec client ip addr add 192.168.1.2/24 dev veth_client

# set veth peers up
sudo ip netns exec hub ip link set veth_hub up
sudo ip netns exec client ip link set veth_client up

# add default route
sudo ip netns exec hub ip route add default dev veth_hub
sudo ip netns exec client ip route add default dev veth_client

# create bridge
sudo ip link add name vbr type bridge
sudo ip link set vbr type bridge stp_state 0
sudo ip link set dev veth_hub master vbr
sudo ip link set dev veth_client master vbr
sudo ip link set dev vbr up

#!/usr/bin/env bash

# cleanup
sudo ip link delete veth_hub
sudo ip link delete veth_client
sudo ip link delete vbr
sudo ip netns delete hub
sudo ip netns delete client

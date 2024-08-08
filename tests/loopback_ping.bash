# create configuration
sudo ip netns exec hub ../easy-wg-quick loop

# setup wireguard hub
sudo ip netns exec hub wg-quick up ./wghub.conf

# setup wireguard client
sudo ip netns exec client wg-quick up ./wgclient_loop.conf

# ping wghub address from wgclient
sudo ip netns exec client ping -c3 -i.2 10.99.20.1

# ping wgclient address from wghub
sudo ip netns exec hub ping -c3 -i.2 10.99.20.10

# easy-wg-quick
easy-wg-quick - Creates Wireguard configuration for hub and peers with ease

## Getting Started

These instructions will get you a copy of the project up and running on your
local machine. This machine (called hub) will act as VPN concentrator. All
other peers connects to hub (as in a "road warrior" configuration).

### Prerequisites

Install [Wireguard](https://www.wireguard.com/) for your operating system on
[local machine](https://www.wireguard.com/install/),
[router](https://openwrt.org/docs/guide-user/services/vpn/wireguard),
[VPS](https://en.wikipedia.org/wiki/Virtual_private_server) or
[container](https://github.com/activeeos/wireguard-docker). This will be your
hub.

As dependences `/bin/sh`, `wg`, `wg-quick`, `awk`, `grep` and `ip` commands
should be available on hub. If `ip` is not available user is required to set
`EXT_NET_IF` and `EXT_NET_IP` variables in script to external network interface
name and IP address (or edit `wghub.conf`). Optionally `qrencode` can be used
to generate [QR codes](https://en.wikipedia.org/wiki/QR_code) for mobile
applications.

#### Debian, Ubuntu

```
sudo apt install wireguard-tools mawk grep iproute2 qrencode
```

#### Fedora, RHEL, CentOS

```
sudo dnf install wireguard-tools gawk grep iproute qrencode
```

#### FreeBSD

```
sudo pkg install net/wireguard graphics/libqrencode
```

#### Installing Wireguard tools (and modules)

This script requires only tools installed, but to use Wireguard module
(or user-space implementation) is also required. Detailed install guide
for various operating systems is available at
[wireguard.com/install](https://www.wireguard.com/install/).

Peers also requires Wireguard installed.
[Android](https://play.google.com/store/apps/details?id=com.wireguard.android)
and [iOS](https://itunes.apple.com/us/app/wireguard/id1441195209?ls=1&mt=8)
are supported.

### Installing

Just download the script and make it executable with `chmod`.

```
wget https://raw.githubusercontent.com/burghardt/easy-wg-quick/master/easy-wg-quick
chmod +x easy-wg-quick
```

Or clone repository.

```
git clone https://github.com/burghardt/easy-wg-quick.git
```

## Usage

Script do not require any arguments. Just run it and it will create usable
Wireguard configuration for hub and one peer. Any sequential invocation creates
another peer configuration within same hub.

```
./easy-wg-quick # 1st run creates hub configuration and one client
./easy-wg-quick # any other runs creates additional clients
```

Passing an argument to script creates configuration file with name instead of
sequence number to help remembering which config was for which device.
Following command will create `wgclient_client_name.conf` file.

```
./easy-wg-quick client_name
```

### Sample output

```
No seqno.txt... creating one!
No wgpsk.key... creating one!
No wghub.key... creating one!
No wghub.conf... creating one!
Wireguard hub address is 10.13.1.140:51820 on wlp9s0.
Note: customize [Interface] section of wghub.conf if required!

Note: passing argument to script creates client configuration with supplied
      name to help remembering which config was for which device. If you
      didn't pass any argument you can still rename created file manually
      with command:
  mv -vi wgclient_10.conf wgclient_name.conf

No wgclient_10.conf... creating one!
█████████████████████████████████████████████████████████████████████████
█████████████████████████████████████████████████████████████████████████
████ ▄▄▄▄▄ █▀██ ▀▄▀▄█▄ ▀▄ █▀▀▄█▄▄▀ ▄▀██▀▀▀▀█▄  █▀▀▄█  ▄▀▀ █▄▀█ ▄▄▄▄▄ ████
████ █   █ █▀▄▀ ▀█▀▄▄▄ ▄ ▀█ ▄██▄█ ▀▀▄ ███▀▀▄▄  ▀ ▄▄▀███▄▀▀ ▀▄█ █   █ ████
████ █▄▄▄█ █▀▀▀██▀▄██  ▀▄███▀▀▀▀▄▄ ▄▄▄ ▄  ▀██  ▄█▀▀  █▀██▄▀█▄█ █▄▄▄█ ████
████▄▄▄▄▄▄▄█▄█▄▀ ▀▄▀▄▀ ▀▄▀▄█ █▄█ █ █▄█ █ █ ▀ ▀▄█ ▀▄▀ ▀▄▀ ▀▄█▄█▄▄▄▄▄▄▄████
████▄▄   █▄ ▄ ██ ▄▄▄█ ▀█▀▄ ▀▄█▄▄█▄▄   ▄   █ █▀▄▀▄▀█▄▀▄▀▀▄▄ █▄ ▀▄▀ ▀ █████
█████▀ ▄▀▀▄▀▀▄█▀  █▀ ▀▀▄▀█▄█▄ ▄▀▀▄▄▄█ ▄▀▀█ ▄ ▀▀▄ ▄▄▄ ▀ █▀▀▀██▀▄█ ▄███████
████ ▄███ ▄▀█▄▀█▄▀ ███▀▀▀▀▀▀▄ ▄   ▀ ██▀  ▄███ ▄ ▀ ▀ ▄▄▀▄█▀▄▀▀ █▀ ▄▄▀ ████
█████▀  ▀▀▄ ▄▀▄▀▄██▄█  ▀ ▀▄▀█ █ █▀▀▄ ▀█▀▄▀█▀▀▄▄█▀ ██▀█▄▄▀█▄ ▀  ▀██▀▄▀████
████▀▄▄▀▀ ▄▄▄▄▄█ ▀█  ▀▀ ▀█ █▀█ ▀▀▄ ▀█▀██▀█ ▄▀▀▀▀▄▀   █▀▄▄▄ █ ▀▀▀ ▄▄ █████
████▀▄▄██ ▄▀▀▀▀█▄▄▄ ▀▄█ ▀▀ ▄▄▄ █▀▄   █▄▄ ▄███▀▄▀██   ▀▀██ ▄ ▀▄  ▄██▀▄████
████▄  ███▄  ▀▄█   ▄▀▄▀▀▀▀▄▀▀▄▄▀   ▄ ▄▄▄▀▄▄█▄▄ ▀█▄▄▀▀▀▄▄▄▀ ▀▄██▀ ▄▄  ████
████ █▄▀▀ ▄██▀▄ █▄▀▄ ▀ █▀ ▄ ▄██▀█ ▄ ██▀▄▄▀   █ ▄▄█  ▀▀  ▄▀█ ▄ ██ ▀▀▄▄████
████   ▄ ▀▄▄▄█▄█▀█▄ ▀▀▀ ▀▀▄▄█  ▀▄▀██ ▀▄█  █ █▄  █▀▀▀  ▀██  ▀▀ ▀▄▀ ██▀████
█████▄ ▀▄▀▄█▄ ▄▄▀█ ▄█   █▄▄▀ ▄▄▀█  ▄█▄▄▄ ▀▀▀▀ ▄▄  █ ▀▄█▄ ▄▄▀▀ █ ▀▄▀▄▄████
████ █▀█▀▄▄▀▀▄ ███ ▀█▀▀▄█▄ ▄  ▄███▀▄▄▀▀  ▀▀▀▀ ▄ █▄▀▄▄▄▀▄▀  ██ █▀ █  ▀████
█████▄▄█ ▄▄▄  █ ▄  ▀█▀ ▄█▀█▄  █▀▄▄ ▄▄▄ ▄  █▄█▄ ██▀▄█▀██▀   ▄ ▄▄▄ ▀▀▄█████
████▀█▀▄ █▄█ █▄█▄▀▀█ █▄▄  ▀███▀███ █▄█  ▄▄▄▀▀█ ▄██▀▀ ▀▀▄▄▄▄▄ █▄█ ██▄▀████
████   ▀ ▄▄  ▀█ ▄█  █▀ ▄█▄█▄▄▀████ ▄  ▄ ▄▄▄███▄▀██▄▄▄▄▄▀▄▄██ ▄ ▄▄▄█ ▄████
████ ▀ ▄▄ ▄ ▄▄ ▄▀▄█▄▀▀  █▄█▀ ▀█▀▀█ █▀██▀▀███▄▀▀▀█▄█▀  ▄█▄  ▄█▄█▀▄   ▀████
████▄▀▄▄▀▄▄█▀▄▄ █▄▄█▀  ▄▀▀█▄ ▄█▀██  ███ █▄▄█▀█▄▀▀▄ ▀▄▀▄ ▀██ ▀▀    ▀▀▄████
████  ▄▀▄▀▄▀ ▄▀▄ ▄  ▀█▄█  ▀▀▄█▄▀█▀▀▄██▀  ▄▀▀▄ ▄█▄██▀ ▄█▄▄▄ ▀ ██▄▀██▀▄████
████▀█ ▄█▄▄▄▄██▄ ▄▄▄█  ▄▀▄▄█▄█▄▀▀▀ █▀ █▀▀▄▀█▀█▀█▀▄█▄ ▀█▄█▀ ▀▄█▄█ ▄▀ ▄████
████▄▀▀█▄▄▄▀▀█▄ ▀█ ▄▀▄ ▀▀█▄▀▄▄▄ ▄▀ ▀▀▀▄▀█ █▀█  ▄▀ ▀█▄ ▀▀█▀▄▄█ █▄█▄██▀████
████▀█▀▄ ▀▄▄  █▄ ▀█▄   ▀ ▄▄▀█▀█▀▄██▀▄  ▄█▀█▀██▀ ▀▄█  ▀██▀▄█▄█▀ █ █▀ █████
█████ █ ▄▄▄ █▀  ▀██ ▀▄ ▄  █████▀█ ▄▀ ▄▄▄█ ▄▄█▄▄ ▄ ▄▄▄█▀▄▄▄▄▄▄▀ ▄█▄▄ █████
████▄█▄ ▄▀▄  ▄▀█▀██▄▀▄█▄█▀   ▄ █▀██ ▀▄ ▄▄▀▀▀▀█▀█ █▄  ▀▀ █  █▀ ▀ ▄██▀▄████
████▄▄ █ █▄▄▄▄ █ ▄▄▀█▄▀█ ▀▄▀ ▄▄ ▀ ▄█ █▄▀▀▄█▀▄  ▀███▀▀ ▄██  █▄▄█▀█▄▄▄▀████
████▀█▄ █▄▄█ █▀ ▄ ▀██ ▀ ▀▄▄▄▄██▄█▄▄▄█▄▄▄▀▀▄▀▄█▀ ▄█  ▄▀▄  ▀█  ▄█ ▄▄▀▄▄████
█████▄▄█▄█▄█▀▄█ ▀ █▄ ▀▀▀▀▀█▄█▄▄ ▄█ ▄▄▄  ▀▄▀██▄▄▀█▄▀▀  █▄█ ▄█ ▄▄▄ █ █▀████
████ ▄▄▄▄▄ █▄██▀▀█▀██▀▀▄█ ▄▀ ▄█▄█▀ █▄█    █▀▀▄█▄  █▄█▄▀█▀  █ █▄█ ▀▀▀▄████
████ █   █ █ █ ▀▄█ ▀███▄██▄▄  ▄ █ ▄▄ ▄▄█ ▄▀▀█▀▄▄▀▀█▄▄▄▀▀▀█ █   ▄▄▄▀ █████
████ █▄▄▄█ █  ▀▄ █▄▀█▀ ▄███▄  █ ▄ ▀█▄ ▄▀ ▀▄▀▀▄ █▀ ▄ ▀▄█▀▄█▀▄▄███▄▀▀ █████
████▄▄▄▄▄▄▄█▄▄██▄▄█▄█▄█▄▄▄▄█▄▄▄██▄█████▄▄█▄▄▄█▄▄████████▄▄▄█▄████████████
█████████████████████████████████████████████████████████████████████████
█████████████████████████████████████████████████████████████████████████
Scan QR code with your phone or use "wgclient_10.conf" file.
Updating wghub.conf... done!

Important: Deploy updated wghub.conf configuration to wireguard with wg-quick:
  sudo wg-quick down ./wghub.conf # if already configured
  sudo wg-quick up ./wghub.conf
  sudo wg show # to check status
```

### Using generated configuration

On hub configure Wireguard.

```
sudo wg-quick up ./wghub.conf
```

On peer scan QR code or copy `wgclient_10.conf`.

Finally on hub check if everything works with `sudo wg show`.

```
interface: wghub
  public key: kbaG3HxSDz3xhqiTNXlo1fZkFa+V6oTl+w0cSAQKxwQ=
  private key: (hidden)
  listening port: 51820

peer: th8qYu0R0mgio2wPu1kz6/5OOgi6l8iy7OobK590LHw=
  preshared key: (hidden)
  endpoint: 10.60.1.150:37218
  allowed ips: 10.127.0.10/32
  latest handshake: 50 minutes, 22 seconds ago
  transfer: 32.64 MiB received, 95.24 MiB sent
```

## Fine tunning

### Disabling external interface autodetection

By default `easy-wg-quick` use interface with default routing done over it as
external network interface of VPN hub. If autodetection fails or generation of
configuration is done outside the hub (i.e. on
[air gapped](https://en.wikipedia.org/wiki/Air_gap_%28networking%29) laptop)
user can set interface name in `extnetif.txt` file with command:

```
echo vtnet0 > extnetif.txt
```

### Disabling external IP address autodetection

By default `easy-wg-quick` uses IP address of interface that has default
routing done over it as external IP address of VPN hub. This might not be true
if hub is behind firewall or NAT/PAT/masquarading is done. User can set
prefered IP address in `extnetip.txt` file with command:

```
echo 192.168.1.2 > extnetip.txt
```

In case of NAT/PAT/masquarading one can try to use service like
[ifconfig.me](https://ifconfig.me/) for autodetection:

```
curl ifconfig.me/ip > extnetip.txt
```

### Disabling random port assignment

By default `easy-wg-quick` use random port number from range 1025-65535. When
using static port number is required for firewall configuration or other
reasons user can set preferred port number (80 in this example) in `portno.txt`
file with command:

```
echo 80 > portno.txt
```

### Setting custom DNS

#### Setting IPv4 resolver address

By default `easy-wg-quick` uses 1.1.1.1 as it's internal DNS. You can use the
command below to serve a custom IPv4 DNS to clients.

```
echo 8.8.8.8 > intnetdns.txt
```

#### Setting IPv6 resolver address

By default `easy-wg-quick` uses 2606:4700:4700::1111 as it's internal DNS. You
can use the command below to serve a custom IPv6 DNS to clients.

```
echo 2001:4860:4860::8888 > intnet6dns.txt
```

### Choosing firewall type

Firewall type is guessed from operating system. For Linux `iptables` and
`ip6tables` are used. For FreeBSD basic `pf` NAT rules are implemented.
File `fwtype.txt` contains name of firewall type. To override autodetection
or disable any rules run one of the following commands:

```
echo iptables > fwtype.txt # to choose Linux netfilter
echo pf > fwtype.txt       # to choose OpenBSD PF
echo custom > fwtype.txt   # to include predefined commands from file
echo none  > fwtype.txt    # to skip any setup during wg-quick up/down
```

If `fwtype.txt` contains word `custom` content of `commands.txt` is included
in the `wghub.conf` file.

Format of `commands.txt` is:
```
PostUp = echo "command 1"
PostUp = echo "command 2"
PostUp = ...

PostDown = echo "command 1"
PostDown = secho "command 2"
PostDown = ...
```

### Enabling IPv6

If global unicast IPv6 address is detected on server tunnels will be created
with inner IPv6 addresses allocated. This allows hub's clients to connect over
hub's IPv6 NAT to IPv6 network.

To use outer IPv6 addresses (i.e. connect client to hub over IPv6) just set
`EXT_NET_IF` and `EXT_NET_IP` variables in script to external network interface
name and IPv6 address (or edit `wghub.conf`).

### Redirecting DNS

DNS redirection might be required to integrate with services like
[Pi-hole](https://pi-hole.net/) or
[Cloudflare DNS over TLS](https://github.com/qdm12/cloudflare-dns-server).
This could be achieved by using port 53 UDP/TCP redirection in `wghub.conf`.

```
PostUp = iptables -t nat -A PREROUTING -i %i -p udp -m udp --dport 53 -j DNAT --to-destination 1.1.1.1:53
PostUp = iptables -t nat -A PREROUTING -i %i -p tcp -m tcp --dport 53 -j DNAT --to-destination 1.1.1.1:53
PostDown = iptables -t nat -D PREROUTING -i %i -p udp -m udp --dport 53 -j DNAT --to-destination 1.1.1.1:53
PostDown = iptables -t nat -D PREROUTING -i %i -p tcp -m tcp --dport 53 -j DNAT --to-destination 1.1.1.1:53
```

When using IPv6 similar rules should be set independently with `ip6tables`.

```
PostUp = ip6tables -t nat -A PREROUTING -i %i -p udp -m udp --dport 53 -j DNAT --to-destination 2606:4700:4700::1111:53
PostUp = ip6tables -t nat -A PREROUTING -i %i -p tcp -m tcp --dport 53 -j DNAT --to-destination 2606:4700:4700::1111:53
PostDown = ip6tables -t nat -D PREROUTING -i %i -p udp -m udp --dport 53 -j DNAT --to-destination 2606:4700:4700::1111:53
PostDown = ip6tables -t nat -D PREROUTING -i %i -p tcp -m tcp --dport 53 -j DNAT --to-destination 2606:4700:4700::1111:53
```

### Persisting configuration with systemd

[Systemd](https://wiki.debian.org/systemd) may load configuration for both hub
and clients using `wg-quick.service`.
Note that also [native support](https://manpages.debian.org/buster/systemd/systemd.netdev.5.en.html#%5BWIREGUARD%5D_SECTION_OPTIONS)
for setting up Wireguard interfaces exists (since version 237).

```
sudo cp wghub.conf /etc/wireguard/wghub.conf
sudo systemctl enable wg-quick@wghub
sudo systemctl start wg-quick@wghub
systemctl status wg-quick@wghub
```

## License

This project is licensed under the GPLv2 License - see the
[LICENSE](LICENSE) file for details.

## Acknowledgments

OpenVPN's [easy-rsa](https://github.com/OpenVPN/easy-rsa) was an inspiration
for writing this script.

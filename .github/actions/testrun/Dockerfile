FROM ubuntu:18.04

RUN apt-get update
RUN apt-get install -y --no-install-recommends iproute2 qrencode
RUN apt-get install -y --no-install-recommends software-properties-common

RUN add-apt-repository --yes ppa:wireguard/wireguard
RUN apt-get install -y --no-install-recommends wireguard-tools

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

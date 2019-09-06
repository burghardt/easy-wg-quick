FROM ubuntu:18.04

RUN apt-get update
RUN apt-get install -y software-properties-common
RUN add-apt-repository --yes ppa:wireguard/wireguard
RUN apt-get install -y wireguard-tools

ADD easy-wg-quick /easy-wg-quick
RUN chmod +x /easy-wg-quick

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

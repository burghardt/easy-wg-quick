FROM alpine:3.19.0

RUN apk add -U wireguard-tools libqrencode-tools

COPY easy-wg-quick /usr/bin/easy-wg-quick
RUN chmod +x /usr/bin/easy-wg-quick

RUN mkdir /pwd
VOLUME /pwd
WORKDIR /pwd

ENTRYPOINT ["/usr/bin/easy-wg-quick"]

FROM alpine:3.19.1

RUN apk add --no-cache wireguard-tools libqrencode-tools

COPY easy-wg-quick /usr/bin/easy-wg-quick
RUN chmod +x /usr/bin/easy-wg-quick && \
    mkdir /pwd

VOLUME /pwd
WORKDIR /pwd

ENTRYPOINT ["/usr/bin/easy-wg-quick"]

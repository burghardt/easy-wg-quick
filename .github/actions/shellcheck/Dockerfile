FROM debian:9.5-slim

RUN apt-get update
RUN apt-get -y install shellcheck

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

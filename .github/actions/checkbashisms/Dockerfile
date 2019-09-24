FROM debian:testing-slim

RUN apt-get update
RUN apt-get -y --no-install-recommends install devscripts

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

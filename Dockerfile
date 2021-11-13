FROM debian:jessie
LABEL maintainer="superpoussin22"

ENV LANG C.UTF-8

RUN apt-get update; apt-get install -y \
    openssl nginx nginx-extras gettext

RUN rm -rf /etc/nginx/conf.d/*; \
    rm -f /etc/nginx/sites-available/default; \
    mkdir -p /etc/nginx/external/pki

RUN sed -i 's/access_log.*/access_log \/dev\/stdout;/g' /etc/nginx/nginx.conf; \
    sed -i 's/error_log.*/error_log \/dev\/stdout info;/g' /etc/nginx/nginx.conf; \
    sed -i 's/^pid/daemon off;\npid/g' /etc/nginx/nginx.conf; \
    sed -i 's/ssl_protocols/#ssl_protocols/' /etc/nginx/nginx.conf; \
    sed -i 's/ssl_prefer_server_ciphers on;/#ssl_prefer_server_ciphers on;/' /etc/nginx/nginx.conf

ADD entrypoint.sh /opt/entrypoint.sh
RUN chmod a+x /opt/entrypoint.sh
RUN mkdir -p /data/nginx/cache
RUN rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/opt/entrypoint.sh"]
CMD ["nginx"]

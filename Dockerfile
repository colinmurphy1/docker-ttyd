FROM alpine:edge
ENV USERNAME="user" \
    PASSWORD="Passw0rd" \
    SUDO_OK="false" \
    AUTOLOGIN="false" \
    TZ="Etc/UTC"

COPY ./entrypoint.sh /
COPY ./skel/ /etc/skel

RUN apk update && \
    apk add --no-cache tini bash ttyd tzdata sudo nano && \
    chmod 700 /entrypoint.sh && \
    touch /etc/.firstrun && \
    ln -s "/usr/share/zoneinfo/$TZ" /etc/localtime && \
    echo $TZ > /etc/timezone 

ENTRYPOINT ["/sbin/tini", "--"]
CMD ["/entrypoint.sh"]

EXPOSE 7681/tcp


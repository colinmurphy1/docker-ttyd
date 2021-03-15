FROM alpine:edge
ENV USERNAME="user" \
    PASSWORD="Passw0rd" \
    SUDO_OK="false" \
    AUTOLOGIN="false" 

COPY ./entrypoint.sh /
COPY ./skel/ /etc/skel

RUN apk update && \
    apk add --no-cache tini bash ttyd sudo nano && \
    chmod 700 /entrypoint.sh && \
    touch /etc/.firstrun

ENTRYPOINT ["/sbin/tini", "--"]
CMD ["/entrypoint.sh"]

EXPOSE 7681/tcp


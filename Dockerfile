FROM alpine:edge
ENV TTYD_USERNAME="user" \
    TTYD_PASSWORD="Passw0rd" \
    TTYD_SUDO="false" \
    TTYD_AUTOLOGIN="false" 

COPY ./entrypoint.sh /
COPY ./skel/ /etc/skel

RUN apk update && \
    apk add --no-cache tini bash ttyd sudo nano && \
    chmod 700 /entrypoint.sh && \
    touch /etc/.firstrun

ENTRYPOINT ["/sbin/tini", "--"]
CMD ["/entrypoint.sh"]

EXPOSE 7681/tcp


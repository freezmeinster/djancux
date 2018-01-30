FROM alpine:latest

EXPOSE 8000

WORKDIR /app/

ENTRYPOINT /app/docker-entrypoint.sh

COPY mambu/requirements.txt /app/requirements.txt

RUN apk update

RUN apk add python3 nginx sudo py3-gevent&& \
    easy_install-3.6 pip && \
    adduser -h /app -D django &&\
    pip install -r /app/requirements.txt && \
    echo "django ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    mkdir /run/nginx && \
    chmod og+w /run/nginx && \
    chown -R django:django /var/lib/nginx/ &&\
    chown -R django:django /var/tmp/nginx/ &&\
    chown -R django:django /var/log/nginx/ &&\
    rm /etc/nginx/conf.d/default.conf

COPY default.conf /etc/nginx/conf.d/default.conf

COPY docker-entrypoint.sh /app/docker-entrypoint.sh

COPY mambu/ /app/

USER django


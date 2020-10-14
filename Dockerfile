FROM nginx:alpine

RUN apk add certbot certbot-nginx

COPY ./config-files/nginx.conf /etc/nginx/nginx.conf
COPY ./config-files/default.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
EXPOSE 443


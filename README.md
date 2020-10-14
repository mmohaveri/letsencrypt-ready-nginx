# Lets Encrypt ready nginx docker

An nginx docker image next to a cert-bot to obtain SSL certificates from Lets Encrypt.

## Running the image

In order to work with this docker image you need to:

1. Mount a volume on /etc/letsencrypt (in order for certbot to store its information and certificates in it)
2. Mount a volume on /etc/nginx/sites-enabled and populate it with your desired Virtual Host configs.

### Obtaining a new certificate

Create a simple HTTP virtual host file for your domain and put it in the folder you're mounting into `/etc/nginx/sites-enabled`.
It probably would be something like:

```nginx
server {
    listen 80;
    listen [::]:80;

    server_name <your-domain-address>;

    return 200;
}
```

Then run:

```bash
docker run -it \
-v <path-to-folder-containing-nginx-configs>:/etc/nginx/sites-enabled \
-v <path-to-letsencrypt-folder>:/etc/letsencrypt \
-p 80:80 \
mmohaveri/letsencrypt-ready-nginx:1.0.0 certbot --nginx
```

Follow the process and you'll get the certificates that you want.

### Running the nginx service

After you've obtained needed certificates, just configure your virtual host file as you want and run:

```bash
docker run -it \
-v <path-to-folder-containing-nginx-configs>:/etc/nginx/sites-enabled \
-v <path-to-letsencrypt-folder>:/etc/letsencrypt \
-p 80:80 \
-p 443:443 \
--name nginx \
mmohaveri/letsencrypt-ready-nginx:1.0.0
```

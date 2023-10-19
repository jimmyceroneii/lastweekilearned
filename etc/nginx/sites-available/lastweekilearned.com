server {

        root /var/www/lastweekilearned.com/html;
        index index.html index.htm index.nginx-debian.html;

        server_name lastweekilearned.com www.lastweekilearned.com;

        location / {
                try_files $uri $uri/ =404;
        }

    listen [::]:443 ssl ipv6only=on; # managed by Certbot
    listen 443 ssl; # managed by Certbot
    ssl_certificate /etc/letsencrypt/live/lastweekilearned.com/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/lastweekilearned.com/privkey.pem; # managed by Certbot
    include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot


}
server {
    if ($host = www.lastweekilearned.com) {
        return 301 https://$host$request_uri;
    } # managed by Certbot


    if ($host = lastweekilearned.com) {
        return 301 https://$host$request_uri;
    } # managed by Certbot


        listen 80;
        listen [::]:80;

        server_name lastweekilearned.com www.lastweekilearned.com;
    return 404; # managed by Certbot




}
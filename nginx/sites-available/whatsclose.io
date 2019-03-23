server {
    if ($host = whatsclose.io) {
        return 301 https://$host$request_uri;
    } # managed by Certbot


    root /var/www/whatsclose.io/;
    index index.html index.htm;

    server_name www.whatsclose.io whatsclose.io;

    location / {
        try_files $uri $uri/ =404;
    }


    # ACME challenge
    location ^~ /.well-known {
      allow all;
      auth_basic off;
      alias /var/lib/letsencrypt/.well-known/;
      default_type "text/plain";
      try_files $uri =404;
    }

    if ($scheme != "https") {
        return 301 https://$host$request_uri;
    } # managed by Certbot


    # Redirect non-https traffic to https
    # if ($scheme != "https") {
    #     return 301 https://$host$request_uri;
    # } # managed by Certbot



}

server {
    listen       443 ssl;
    server_name whatsclose.io;
#    ssl_certificate /etc/letsencrypt/live/whatsclose.io-0001/fullchain.pem; # managed by Certbot
#    ssl_certificate_key /etc/letsencrypt/live/whatsclose.io-0001/privkey.pem; # managed by Certbot
#    ssl_trusted_certificate /etc/letsencrypt/live/whatsclose.io/chain.pem;

    ssl_session_cache    shared:SSL:1m;
    ssl_session_timeout  5m;

    ssl_ciphers  HIGH:!aNULL:!MD5;
    ssl_prefer_server_ciphers  on;

    root /var/www/whatsclose.io/;
    index index.html index.htm;

    location / {
        try_files $uri $uri/ =404;
    }

    ## Block download agents
    if ($http_user_agent ~* LWP::Simple|wget|libwww-perl) {
        return 403;
    }

    ## Block some nasty robots
    if ($http_user_agent ~ (msnbot|Purebot|Baiduspider|Lipperhey|Mail.Ru|scrapbot) ) {
        return 403;
    }

    ## Deny referal spam
    if ( $http_referer ~* (jewelry|viagra|nude|girl|nudit|casino|poker|porn|sex|teen|babes) ) {
        return 403;
    }



    ssl_certificate /etc/letsencrypt/live/whatsclose.io-0001/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/whatsclose.io-0001/privkey.pem; # managed by Certbot
}

server {
  listen 443 ssl http2;
  listen [::]:443 ssl http2;
    ssl_certificate /etc/letsencrypt/live/www.whatsclose.io/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/www.whatsclose.io/privkey.pem; # managed by Certbot
  ssl_trusted_certificate /etc/letsencrypt/live/whatsclose.io/chain.pem;
  server_name www.whatsclose.io;

  root /var/www/whatsclose.io/;
  index index.html index.htm;

    location / {
        try_files $uri $uri/ =404;
    }

    ## Block download agents
    if ($http_user_agent ~* LWP::Simple|wget|libwww-perl) {
        return 403;
    }

    ## Block some nasty robots
    if ($http_user_agent ~ (msnbot|Purebot|Baiduspider|Lipperhey|Mail.Ru|scrapbot) ) {
        return 403;
    }

    ## Deny referal spam
    if ( $http_referer ~* (jewelry|viagra|nude|girl|nudit|casino|poker|porn|sex|teen|babes) ) {
        return 403;
    }


}

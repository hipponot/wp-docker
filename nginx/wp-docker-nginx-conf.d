# coding: utf-8

daemon off;  # https://stackoverflow.com/questions/18861300/how-to-run-nginx-within-a-docker-container-without-halting

worker_processes  2;

http {
  server {
    listen         80;
    listen         443 ssl;
    server_name    *.wootmath.com;

    location / {
      proxy_set_header   X-Forwarded-For $remote_addr;
      proxy_set_header   Host $http_host;
      proxy_pass         "http://woot-math-wordpress:80";
    }

    ssl_certificate /etc/ssl/fullchain.pem;
    ssl_certificate_key /etc/ssl/privkey.pem;
    # --
    # The following settings are for SSL security and performance (including forward secrecy)
    # See:
    #   https://community.qualys.com/blogs/securitylabs/2013/08/05/configuring-apache-nginx-and-openssl-for-forward-secrecy
    #   https://community.qualys.com/blogs/securitylabs/2013/06/25/ssl-labs-deploying-forward-secrecy 
    #   http://blog.cloudflare.com/ocsp-stapling-how-cloudflare-just-made-ssl-30
    ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
    ssl_ciphers "EECDH+ECDSA+AESGCM EECDH+aRSA+AESGCM EECDH+ECDSA+SHA384 EECDH+ECDSA+SHA256 EECDH+aRSA+SHA384 EECDH+aRSA+SHA256 EECDH+aRSA+RC4 EECDH EDH+aRSA RC4 !aNULL !eNULL !LOW !3DES !MD5 !EXP !PSK !SRP !DSS";
    ssl_prefer_server_ciphers on;
 
    gzip  on;
    gzip_vary on;
    gzip_min_length 500;
    gzip_disable "MSIE [1-6]\.(?!.*SV1)";
    gzip_types text/plain text/xml text/css
       text/comma-separated-values
       text/javascript application/x-javascript
       application/atom+xml image/x-icon;

    root /var/www/html;
  }

  # redirect http://wp-admin traffic to https
  # (non-wildcard server name has precedence)
  server {
    listen 80;
    listen [::]:80;
    server_name wp-admin.wootmath.com
    return 301 https://wp-admin.wootmath.com$request_uri;
 
 
  # https://wp-admin.wootmath.com
  # Include access and error logs
  # (non-wildcard server name has precedence)
  server {
    listen         443 ssl;
    server_name    wp-admin.wootmath.com;

    location / {
      proxy_set_header   X-Forwarded-For $remote_addr;
      proxy_set_header   Host $http_host;
      proxy_pass         "http://woot-math-wordpress:80";
    }

    ssl_certificate /etc/ssl/fullchain.pem;
    ssl_certificate_key /etc/ssl/privkey.pem;
    # --
    # The following settings are for SSL security and performance (including forward secrecy)
    # See:
    #   https://community.qualys.com/blogs/securitylabs/2013/08/05/configuring-apache-nginx-and-openssl-for-forward-secrecy
    #   https://community.qualys.com/blogs/securitylabs/2013/06/25/ssl-labs-deploying-forward-secrecy 
    #   http://blog.cloudflare.com/ocsp-stapling-how-cloudflare-just-made-ssl-30
    ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
    ssl_ciphers "EECDH+ECDSA+AESGCM EECDH+aRSA+AESGCM EECDH+ECDSA+SHA384 EECDH+ECDSA+SHA256 EECDH+aRSA+SHA384 EECDH+aRSA+SHA256 EECDH+aRSA+RC4 EECDH EDH+aRSA RC4 !aNULL !eNULL !LOW !3DES !MD5 !EXP !PSK !SRP !DSS";
    ssl_prefer_server_ciphers on;

    root /var/www/html;

    access_log /var/www/log/wp-admin/nginx.access.log;
    error_log  /var/www/log/wp-admin/nginx.error.log info;
  }
}


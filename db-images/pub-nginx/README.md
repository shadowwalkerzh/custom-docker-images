### pub-nginx

#### Project Structure
```
├── data
│   ├── conf.d
│   │   ├── 1-common.conf
│   │   ├── 2-nginx-status.conf
│   │   ├── default.conf
│   │   ├── sample-domain.conf
│   │   ├── subconf
│   │   │   ├── auto-https.conf
│   │   │   ├── common-proxy-setting.conf
│   │   │   ├── mime.types
│   │   │   └── ssl
│   │   │       ├── sample-domain.crt
│   │   │       ├── sample-domain.key
│   │   │       └── ssl-sample-domain.conf
│   │   └── zz-upstreams.conf
│   ├── etc
│   │   └── nginx.conf
│   └── www
│       └── sample-web
```

- Mount volumes:
  - /opt/pub-nginx/data/log:/var/log/nginx
  - /opt/pub-nginx/data/conf.d:/etc/nginx/conf.d
  - /opt/pub-nginx/data/www:/usr/share/nginx
  - /opt/pub-nginx/data/etc/nginx.conf:/etc/nginx/nginx.conf

- Main nginx config file: ./data/etc/nginx.conf
- SSL config: ./data/conf.d/subconf/ssl/ssl-*.conf
- Custom common config: ./data/conf.d/subconf/*.conf
- Domain config: ./data/conf.d/*.conf
- Upstream config: ./data/conf.d/zz-upstreams.conf
- Nginx logs: ./data/log
- Statistics projects: ./data/www/{project name}


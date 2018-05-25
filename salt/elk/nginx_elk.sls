nginx_config_elk:

    file.managed:
        - name: /etc/nginx/conf.d/proxy_elk.conf
        - create: Yes
        - mode: 644
        - contents: |
            server {
                listen 80;

                server_name elk;

                auth_basic "Restricted Access";
                auth_basic_user_file /etc/nginx/htpasswd.users;

                location / {
                    proxy_pass http://localhost:5601;
                    proxy_http_version 1.1;
                    proxy_set_header Upgrade $http_upgrade;
                    proxy_set_header Connection 'upgrade';
                    proxy_set_header Host $host;
                    proxy_cache_bypass $http_upgrade;
                }
            }

    cmd.run:
        - name: htpasswd -bc /etc/nginx/htpasswd.users elk_master pa55
        - runas: root

    service.running:
        - name: nginx
        - enable: True
        - reload: True

remove_default_config:

    cmd.run:
        - name: | 
            rm -rf /etc/nginx/conf.d/default.conf
            systemctl restart nginx
        - runas: root
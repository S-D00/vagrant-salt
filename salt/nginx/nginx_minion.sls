nginx_config_minion:

    file.managed:
        - name: /etc/nginx/conf.d/proxy_config_master.conf
        - create: True
        - mode: 644
        - contents: | 
            upstream minion {
              server 192.168.73.15:8080;
            }

            server {

                listen 80;
                server_name minion;

                location / {

                  proxy_pass              http://192.168.73.15:8080;
                  proxy_set_header        Host $host;
                  proxy_set_header        X-Real-IP $remote_addr;
                  proxy_set_header        X-Forwarded-For $proxy_add_x_forwarded_for;
                  proxy_set_header        X-Forwarded-Proto $scheme;
              }
            }

    service.running:
        - name: nginx
        - enable: True
        - reload: True
        - watch:
            - file: /etc/nginx/conf.d/proxy_config_master.conf
    
    cmd.run:
        - name: |
            rm -rf /etc/nginx/conf.d/default.conf
            systemctl restart nginx
        - runas: root



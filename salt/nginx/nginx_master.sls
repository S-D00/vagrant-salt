nginx_config_master:

    file.managed:
        - name: /etc/nginx/conf.d/proxy_config_master.conf
        - create: True
        - mode: 644
        - contents: | 
            upstream salt {
                server 192.168.73.14:8080;
              }
            
            server {
            
                listen 80;
                server_name salt;
                
                location / {

                  proxy_set_header        Host $host;
                  proxy_set_header        X-Forwarded-Host $host; 
                  proxy_set_header        X-Real-IP $remote_addr;
                  proxy_set_header        X-Forwarded-For $proxy_add_x_forwarded_for;
                  proxy_set_header        X-Forwarded-Proto $scheme;

                  proxy_pass              http://127.0.0.1:8080;
                  proxy_read_timeout      90;
            
                  
                  proxy_http_version 1.1;
                  proxy_request_buffering off;
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



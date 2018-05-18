install_nginx:
    pkgrepo.managed:
        - name: | 
            deb http://nginx.org/packages/ubuntu/ xenial nginx
            deb-src http://nginx.org/packages/ubuntu/ xenial nginx
        - keyid: ABF5BD827BD9BF62
        - keyserver: keyserver.ubuntu.com
        - require_in:
            - pkg: nginx

    pkg.installed:
        - name: nginx

    service.running:
        - name: nginx
        - enable: True
        - reload: True
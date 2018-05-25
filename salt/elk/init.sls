register_repo:

    pkgrepo.managed:
        - name: deb https://artifacts.elastic.co/packages/6.x/apt stable main
        - file: /etc/apt/sources.list.d/elastic-6.x.list
        - key_url: https://artifacts.elastic.co/GPG-KEY-elasticsearch

install_elasticsearch:

    pkg.installed:
        - name: elasticsearch

    service.running:
        - name: elasticsearch
        - enable: True
        - reload: True


install_kibana:
    
    pkg.installed:
        - name: kibana

    service.running:
        - name: kibana
        - enable: True
        - reload: True
        



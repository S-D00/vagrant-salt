register_repo_beats:

    pkgrepo.managed:
        - name: deb https://artifacts.elastic.co/packages/6.x/apt stable main
        - file: /etc/apt/sources.list.d/elastic-6.x.list
        - key_url: https://artifacts.elastic.co/GPG-KEY-elasticsearch

install_metricbeat:

    pkg.installed:
        - name: metricbeat
    
    service.running:
        - name: metricbeat
        - enable: True
        - reload: True

install_heartbeat:

    pkg.installed:
        - name: heartbeat-elastic

    service.running:
        - name: heartbeat-elastic 
        - enable: True
        - reload: True
            

install_jenkins:

    pkgrepo.managed:
        - name: deb http://pkg.jenkins.io/debian-stable binary/
        - file: /etc/apt/sources.list.d/jenkins.list
        - key_url: https://pkg.jenkins.io/debian/jenkins.io.key

        
    pkg.installed:
        - pkgs:
            - jenkins

    cmd.run:
        - name: sleep 1m
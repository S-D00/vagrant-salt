install_jenkins:

    cmd.run:
        - name: wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
    
    pkgrepo.managed:
        - name: deb http://pkg.jenkins.io/debian-stable binary/
        
    pkg.installed:
        - pkgs:
            - jenkins



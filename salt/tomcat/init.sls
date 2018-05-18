install_tomcat:

    group.present:
        - name: tomcat

    file.directory:
            - name: /opt/tomcat
            - group: tomcat
            - makedirs: True

    git.latest:
        - name: https://github.com/S-D00/tomcat.git
        - target: /opt/tomcat

    user.present:
        - name: tomcat
        - home: /opt/tomcat
        - groups:
            - tomcat
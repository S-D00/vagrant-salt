update_tomcat_folder_permissions:

    cmd.run: 
        - name: |
            chgrp -R tomcat conf
            chmod g+rwx conf
            chown -R tomcat:tomcat /opt/tomcat
            chown -R tomcat work/
            chgrp -R tomcat /opt/tomcat/webapps
            chmod -R g+w /opt/tomcat/webapps
        - cwd : /opt/tomcat
        - runas: root

    file.managed:
        - name: /etc/systemd/system/tomcat.service
        - create: True
        - contents: |
            [Unit]
            Description=Tomcat Server
            After=network.target

            [Service]
            Type=forking

            Environment=JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre
            Environment=CATALINA_PID=/opt/tomcat/temp/tomcat.pidEnvironment=CATALINA_HOME=/opt/tomcat
            Environment=CATALINA_BASE=/opt/tomcat
            Environment='CATALINA_OPTS=-Xms512M -Xmx1024M -server -XX:+UseParallelGC'Environment='JAVA_OPTS=-Djava.awt.headless=true -Djava.security.egd=file:/dev/./urandom'

            ExecStart=/opt/tomcat/bin/startup.sh
            ExecStop=/opt/tomcat/bin/shutdown.sh

            User=tomcat
            Group=tomcat
            UMask=0007
            RestartSec=10
            Restart=always

            [Install]
            WantedBy=multi-user.target

    service.running:
        - name: tomcat.service
        - enable: True
        - reload: True
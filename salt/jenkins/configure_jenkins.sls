wait_1:

    cmd.run:
        - name: sleep 1m
        - runas: root

create_jenkins_user:

    cmd.run:
        - name:
            echo 'jenkins.model.Jenkins.instance.securityRealm.createAccount("jadmin", "pa55")' | java -jar /var/cache/jenkins/war/WEB-INF/jenkins-cli.jar -auth admin:`cat /var/lib/jenkins/secrets/initialAdminPassword` -s http://localhost:80/ groovy =
        - runas: root

set_initial_setup_complete:

    file.append:
        - name: /etc/default/jenkins
        - text: JAVA_ARGS="-Djenkins.install.runSetupWizard=false"

    cmd.run: 
        - name: 
            echo 'import jenkins.model.*; import hudson.util.*; import jenkins.install.*; def instance = Jenkins.getInstance() instance.setInstallState(InstallState.INITIAL_SETUP_COMPLETED)' | java -jar /var/cache/jenkins/war/WEB-INF/jenkins-cli.jar -auth admin:`cat /var/lib/jenkins/secrets/initialAdminPassword` -s http://localhost:80/ groovy =
        - runas: root

restart_service_1:
    
    cmd.run:
        - name: systemctl restart jenkins
        - runas: root

    service.running:
        - name: jenkins
        - enable: True
        - reload: True

wait_2:

    cmd.run:
        - name: sleep 1m
        - runas: root

set_JNLP4:

        cmd.run:
            - name:
                echo "import jenkins.model.*; import hudson.util.*; import jenkins.install.*; def instance = Jenkins.getInstance(); Set<String> agentProtocolsList = ['JNLP4-connect', 'Ping']; instance.setAgentProtocols(agentProtocolsList);instance.save()" | java -jar /var/cache/jenkins/war/WEB-INF/jenkins-cli.jar -auth admin:`cat /var/lib/jenkins/secrets/initialAdminPassword` -s http://localhost:80/ groovy =
            - runas: root

install_plugins:

    cmd.run:
        - name:
            java -jar /var/cache/jenkins/war/WEB-INF/jenkins-cli.jar -auth admin:`cat /var/lib/jenkins/secrets/initialAdminPassword` -s http://localhost:80/ install-plugin maven-plugin deploy git github -restart
        - runas: root

    service.running:
        - name: jenkins
        - enable: True
        - reload: True

restart_service_2:

    cmd.run: 
        - name: systemctl restart jenkins

    service.running:
        - name: jenkins
        - enable: True
        - reload: True


set_maven_home:

        cmd.run:
            - name: |
                sleep 1m
                echo "import jenkins.model.*; import hudson.util.*; import jenkins.install.*; a=Jenkins.instance.getExtensionList(hudson.tasks.Maven.DescriptorImpl.class)[0]; b=(a.installations as List); b.add(new hudson.tasks.Maven.MavenInstallation('Maven','/usr/share/maven',[])); a.installations=b; a.save()" | java -jar /var/cache/jenkins/war/WEB-INF/jenkins-cli.jar -auth admin:`cat /var/lib/jenkins/secrets/initialAdminPassword` -s http://localhost:80/ groovy =
            - runas: root

add_credentials:

        cmd.run:
            - name:
                echo '<com.cloudbees.plugins.credentials.impl.UsernamePasswordCredentialsImpl>                                      
                <scope>GLOBAL</scope>
                <id>tomcat</id>
                <description>credentials for tomcat deploy</description>
                <username>admin</username>
                <password>
                    admin
                </password>                                                                                                            
                </com.cloudbees.plugins.credentials.impl.UsernamePasswordCredentialsImpl>' | java -jar /var/cache/jenkins/war/WEB-INF/jenkins-cli.jar -s http://127.0.0.1:80/ -auth admin:`sudo cat /var/lib/jenkins/secrets/initialAdminPassword` create-credentials-by-xml system::system::jenkins _
            - runas: root

create_job:

    cmd.run:
        - name: java -jar /var/cache/jenkins/war/WEB-INF/jenkins-cli.jar -s http://localhost:80/ -auth admin:`sudo cat /var/lib/jenkins/secrets/initialAdminPassword` create-job World_Maven < /vagrant/jenkins_job.xml
        - runas: root


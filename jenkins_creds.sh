sudo echo '<com.cloudbees.plugins.credentials.impl.UsernamePasswordCredentialsImpl>                                      
<scope>GLOBAL</scope>
  <id>tomcat</id>
  <description>credentials for tomcat deploy</description>
  <username>admin</username>
  <password>
    admin
  </password>                                                                                                            
</com.cloudbees.plugins.credentials.impl.UsernamePasswordCredentialsImpl>' | java -jar /vagrant/jenkins-cli.jar -s http://192.168.73.14:80/ -auth admin:`sudo cat /var/lib/jenkins/secrets/initialAdminPassword` create-credentials-by-xml system::system::jenkins _
echo "import jenkins.model.*; import hudson.util.*; import jenkins.install.*; a=Jenkins.instance.getExtensionList(hudson.tasks.Maven.DescriptorImpl.class)[0]; b=(a.installations as List); b.add(new hudson.tasks.Maven.MavenInstallation('Maven','/usr/share/maven',[])); a.installations=b; a.save()" | java -jar /var/cache/jenkins/war/WEB-INF/jenkins-cli.jar -auth admin:`cat /var/lib/jenkins/secrets/initialAdminPassword` -s http://localhost:80/ groovy =
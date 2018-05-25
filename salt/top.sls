base:
  '*':
    - java.init
    - git.init
    - nginx.init
    - elk.beats
    
  'salt':
    - maven.init
    - nginx.nginx_master
    - jenkins.init
    - git.add_repo
    - jenkins.configure_jenkins

  'minion':
    - tomcat.init
    - tomcat.permissions
    - nginx.nginx_minion

  'elk':
    - elk.init
    - elk.nginx_elk
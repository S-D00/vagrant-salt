create_folder:
    file.directory:
        - name: /home/world
        - makedirs: True

pull_repo:
    cmd.run:
        - name: | 
             git init
        - cwd: /home/world

    git.latest:
        - name: https://github.com/S-D00/hello_w.git
        - target: /home/world

    file.managed:
        - name: 
                /home/world/.git/hooks/post-merge
        - create: yes
        - mode: 110
        - contents: | 
            #!/bin/sh
                curl http://localhost:80/git/notifyCommit?url=/home/world

create_hook:
    file.managed:
        - name: 
             /home/world/.git/hooks/post-commit
        - create: yes
        - mode: 110
        - contents: | 
            #!/bin/sh
                curl http://localhost:80/git/notifyCommit?url=/home/world

                
curl -L https://bootstrap.saltstack.com -o /vagrant/install_salt.sh

sudo sh /vagrant/install_salt.sh -M

sudo printf 'file_roots:\n  base:\n    - /srv/salt' >> /etc/salt/master

sleep 1m

sudo salt-key -A -y
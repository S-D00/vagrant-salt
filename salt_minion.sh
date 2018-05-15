curl -L https://bootstrap.saltstack.com -o /vagrant/install_salt.sh

sudo sh /vagrant/install_salt.sh

sudo printf '192.168.73.14 salt' >> /etc/hosts
# Install Proxy
sudo apt-get update

sudo cd /tmp

sudo curl -OL https://github.com/sysown/proxysql/releases/download/v2.0.2/proxysql_2.0.2-dbg-ubuntu18_amd64.deb

sudo dpkg -i proxysql_*

sudo rm proxysql_*

# Install MySQL Client
sudo apt-get install mysql-client -y

# Allow Port Proxy
sudo ufw allow 33061

sudo ufw allow 3306

# Allow Firewall
sudo ufw allow from 192.168.33.12

sudo ufw allow from 192.168.33.13

sudo ufw allow from 192.168.33.14

# Enable and Start Service
sudo systemctl enable proxysql

sudo systemctl start proxysql

# Export Files Configuration to ProxySQL
sudo mysql -u admin -p -h 127.0.0.1 -P 6032 --prompt='ProxySQLAdmin> ' < /vagrant/mysql-dump/proxy_config.sql

# Run This On Clusterdb2/3
# Download Files Addition SYS
#curl -OL https://gist.github.com/lefred/77ddbde301c72535381ae7af9f968322/raw/5e40b03333a3c148b78aa348fd2cd5b5dbb36e4d/addition_to_sys.sql

# Run This On Clusterdb2/3
# Export Files Addition
#sudo mysql -u root -p < addition_to_sys.sql

# Run This On Clusterdb2/3
# Export Files Proxy Connect Configuration
#sudo mysql -u root -p < /vagrant/mysql-dump/proxy_config_connection.sql

  # install apache, dan php
#sudo apt-get install -y apache2 php libapache2-mod-php php-mcrypt php-mysql

# install wordpress
#wget -c http://wordpress.org/latest.tar.gz
#tar -xzvf latest.tar.gz
#sudo mv wordpress/* /var/www/html
#sudo chown -R www-data:www-data /var/www/html
#sudo chmod -R 755 /var/www/html
#sudo service apache2 restart

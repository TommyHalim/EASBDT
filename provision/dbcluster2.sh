# Update repositories
sudo apt-get update

# Install Libraries Perl
sudo apt-get install libclass-methodmaker-perl libaio1 libmecab2

# Copy MySQL Data Node
sudo cp '/vagrant/install/mysql-cluster-community-data-node_7.6.9-1ubuntu18.04_amd64.deb' '/home/vagrant/mysql-cluster-community-data-node_7.6.9-1ubuntu18.04_amd64.deb'

# Install MySQL Data Node
sudo dpkg -i '/home/vagrant/mysql-cluster-community-data-node_7.6.9-1ubuntu18.04_amd64.deb'

# Copy MySQL Data Node Configuration
sudo cp '/vagrant/files/clusterdb2/my.cnf' '/etc/my.cnf'

# Create Folder Data Node
sudo mkdir -p /usr/local/mysql/data

# Starting Node
sudo ndbd

# Allow Firewall
sudo ufw allow from 192.168.33.11

sudo ufw allow from 192.168.33.13

sudo ufw allow from 192.168.33.14

# Kill Service Data Node
sudo pkill -f ndbd

# Copy Configuration Service Data Node
sudo cp '/vagrant/files/clusterdb2/ndbd.service' '/etc/systemd/system/ndbd.service'

# Reload Service
sudo systemctl daemon-reload

# Enable Startup Data Node Service
sudo systemctl enable ndbd

# Starting Data Node Service
sudo systemctl start ndbd

# Installation MySQL API
# Get Download Files MySQL Server
#sudo curl --retry 20 \ -OL https://dev.mysql.com/get/Downloads/MySQL-Cluster-7.6/mysql-cluster_7.6.9-1ubuntu18.04_amd64.deb-bundle.tar
sudo cp '/vagrant/files/clusterdb2/mysql-cluster_7.6.9-1ubuntu18.04_amd64.deb-bundle.tar' 'mysql-cluster_7.6.9-1ubuntu18.04_amd64.deb-bundle.tar'

# Create MySQL Server Installation Folder
sudo mkdir install

# Untar MySQL Requirements
sudo tar -xvf mysql-cluster_7.6.9-1ubuntu18.04_amd64.deb-bundle.tar -C install/

# Install MySQL Common
sudo dpkg -i '/home/vagrant/install/mysql-common_7.6.9-1ubuntu18.04_amd64.deb'

# Install MySQL Cluster Client
sudo dpkg -i '/home/vagrant/install/mysql-cluster-community-client_7.6.9-1ubuntu18.04_amd64.deb'

# Install MySQL Client
sudo dpkg -i '/home/vagrant/install/mysql-client_7.6.9-1ubuntu18.04_amd64.deb'

# Install MySQL Server
#sudo dpkg -i '/home/vagrant/install/mysql-cluster-community-server_7.6.9-1ubuntu18.04_amd64.deb'

# Copy Configuration MySQL Server
#sudo cp '/vagrant/files/clusterdb2/mysql/my.cnf' '/etc/mysql/my.cnf'

# Restarting MySQL Service
#sudo systemctl restart mysql

# Enable Startup MySQL Service
#sudo systemctl enable mysql
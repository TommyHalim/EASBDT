# Update repositories
sudo apt-get update

# Copy MySQL Cluster Manager
sudo cp '/vagrant/install/mysql-cluster-community-management-server_7.6.9-1ubuntu18.04_amd64.deb' '/home/vagrant/mysql-cluster-community-management-server_7.6.9-1ubuntu18.04_amd64.deb'

# Install MySQL Cluster
sudo dpkg -i mysql-cluster-community-management-server_7.6.9-1ubuntu18.04_amd64.deb

# Create Folder MySQL Cluster
sudo mkdir /var/lib/mysql-cluster

# Copy Config MySQL Cluster
sudo cp '/vagrant/files/clusterdb1/config.ini' '/var/lib/mysql-cluster/config.ini'

# Starting Manager
sudo ndb_mgmd -f /var/lib/mysql-cluster/config.ini

# Kill Service
sudo pkill -f ndb_mgmd

# Copy Service Configuration
sudo cp '/vagrant/files/clusterdb1/ndb_mgmd.service' '/etc/systemd/system/ndb_mgmd.service'

# Reload Service
sudo systemctl daemon-reload

# Enable Startup Manager
sudo systemctl enable ndb_mgmd

# Starting Service
sudo systemctl start ndb_mgmd

# Allow Firewall
sudo ufw allow from 192.168.33.12

sudo ufw allow from 192.168.33.13
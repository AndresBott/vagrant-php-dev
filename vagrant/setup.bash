#!/usr/bin/env bash
#=============================================================================================================
## add a better bashrc for root shell
#=============================================================================================================
sudo cp /vagrant/rootbashrc /root/.bashrc
sudo chown root:root /root/.bashrc

sudo cp /vagrant/vagrantbashrc /home/vagrant/.bashrc
sudo chown vagrant:vagrant /home/vagrant/.bashrc

#=============================================================================================================
## install apps
#=============================================================================================================
sudo apt-get update
sudo apt-get install -y nginx-full php-fpm joe htop curl php-mysql php-xml php-gd php-zip php-curl php-sqlite3

## Clean files
sudo rm -f /etc/php/7.0/fpm/pool.d/www.conf

## create vhost dir and user
sudo mkdir -p /vhosts

#=============================================================================================================
# Create user
#=============================================================================================================
USER="vagrant"
sudo id -u $USER &>/dev/null || useradd -d /vhosts -u 1000 $USER
sudo usermod -a -G $USER www-data
sudo usermod -a -G vagrant www-data
sudo usermod -a -G vagrant $USER

sudo mkdir -p /vhosts/$USER/public_html
sudo mkdir -p /vhosts/$USER/temp

sudo chown -R $USER:$USER /vhosts/$USER/
sudo chmod -R 750 /vhosts/$USER/
#=============================================================================================================
# configure php
#=============================================================================================================
if [ -f /host_project/php-pool.conf ]; then
  sudo cp /host_project/php-pool.conf /etc/php/7.0/fpm/pool.d/
else
  sudo cp /vagrant/php-pool.conf /etc/php/7.0/fpm/pool.d/
fi
sudo /etc/init.d/php7.0-fpm restart

sudo mkdir -p /var/$USER/phpSessions
sudo chown $USER:$USER /var/$USER/phpSessions


#=============================================================================================================
# configure nginx
#=============================================================================================================
if [ -f /host_project/nginx-site.conf ]; then
  sudo cp /host_project/nginx-site.conf /etc/nginx/sites-available/
else
  sudo cp /vagrant/nginx-site.conf  /etc/nginx/sites-available/
fi

sudo ln -sf /etc/nginx/sites-available/nginx-site.conf /etc/nginx/sites-enabled/nginx-site.conf
sudo rm -f /etc/nginx/sites-enabled/default
sudo /etc/init.d/nginx restart

#=============================================================================================================
# less restrictive dev environment for vagrant user
#=============================================================================================================
sudo usermod -a -G vagrant www-data
sudo usermod -a -G vagrant $USER

#=============================================================================================================
# configure Mysql
#=============================================================================================================
sudo apt-get update
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'
sudo apt-get -y install mysql-server 
mysql -u root -proot -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'root' WITH GRANT OPTION; FLUSH PRIVILEGES; SET GLOBAL max_connect_errors=10000;"
sudo /etc/init.d/mysql restart



# vagrant-php-dev

Vagrant project for creating reusable php dev environment

# config
vagrant file will check for ../vagrantConfig.yaml before falling back to ./vagrantConfig.yaml 

This is in order to clone the vagrant project in a sub folder to the project folder

same applies to nginx-site.conf an php-poo.conf; the setup will search for the files in the mounted src dir before 
falling back to ./   
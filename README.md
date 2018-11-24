#About
this vagrant project is intended to be added as submodule in a php project for abstracting the developement environment

the goal is that a sql dump should be taken on every vagrant shutdown, 
and sql restore on every vagrant provision
# vagrant-php-dev

Vagrant project for creating reusable php dev environment

# config
vagrant file will check for ../vagrantConfig.yaml before falling back to ./vagrantConfig.yaml 

This is in order to clone the vagrant project in a sub folder to the project folder

same applies to nginx-site.conf an php-poo.conf; the setup will search for the files in the mounted src dir before 
falling back to ./   
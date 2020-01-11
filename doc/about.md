#mounts
````
mounts:
  - host: ../demo-content/vagrant-web
    vagrant: /

  - host: ../demo-content/public_html
    vagrant: /public_html

````
Mounts is a list of folders on the host to be mounted into the vagrant VM 

* host: path to the folder to be mounted on the host, relative to the vagrant file
* vagrant: mountpoint in the vagrant web server path `/` corresponds to `/vhosts/vagrant/www` 
directories will be mounted in order, recursive mounting is possible  


# Database backup-restore

````
# path on the host where the mysql dumps will be created
mysql_mount: ../demo-content/db
# add a cron job every 10 min to dump the database
cron_dump: true
# mysql dump files
mysqldump:
  - db_name: prepare
    run_on_shutdown: false

  - db_name: vagrant
    run_on_shutdown: true

````

After starting the VM all database files will be executed with mysql

Before shutting down, suspending or halting a VM a DB dump will be performed

* db_name: name of the database(and file on host) to dump/restore
* run_on_shutdown: if true this sql file will only run when shutting down the VM,
 set to false if you want to execute a sql to i.e. create users on start
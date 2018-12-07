#mounts
````
mounts:
  - host: ../wpinstall
    client: /host_project
    loop_mount: /vhosts/web
    uid: 1100 
    gid: 1100 
    owner: web
    group: web

````
Mounts is an array of dictionaries where only key host and client is mandatory

* host: path to the folder to be mounted on the host, relative to the vagrant file
* client: absolute path of the mountpoint int the client, note: parent mount folder needs to exist, if this is not
the case, use the option loop_mount
* loop_mount, will create a loop mount on the guest from location client to the loop_mount location
* uid: if you need to specify a uid, for example used does not exist yet
* gid: if you need to specify a gid, for example used does not exist yet
* user: user for which it is mounted
* group: group for which it is mounted

# Database dump
Before shutting down, suspending or halting a VM a DB dump will be performed
````
mysqldump:
  - db_name: db1
    output: /host_project/db/
    only_restore: true
````
* db_name: name of the database to dump
* output: absolute path where the dump will be stored with patterns: "$db_name.sqldump"
* only_restore: if true this sql file will only run when restoring a VM, useful for creating users etc
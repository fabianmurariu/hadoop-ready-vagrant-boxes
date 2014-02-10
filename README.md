hadoop-ready-vagrant-boxes
==========================

Vagrant script and resources for a hadoop ready cluster. This is just the base OS, hadoop is not installed but Ambari is.

* 1) Install vagrant from here http://www.vagrantup.com/downloads.html
* 2) Install Virtualbox or read vagrant docs for Amazon 
* 3) replace jdk-7u51-linux-x64.tar.gz with the actual file from oracle, only version 7u51 works out of the box for something else change bootstrapCentOs.sh so the names match
* 4) download the centos box from http://www.vagrantbox.es/
``` 
vagrant box add centos65 http://puppet-vagrant-boxes.puppetlabs.com/centos-59-x64-vbox4210-nocm.box
```
* 5) Open Vagrant and change the names of the domain or network or external network as you see fit
```
vagrant up /hadoop[1-5]/
```
or just 
```
vagrant up hadoop1
```
* 6) Once everything is up go to http://hadoop1:8080 of course you need to make your own host machine aware of the names of the boxes by adding them into /etc/hosts
* 7) If you need more than 5 you need to change RANGE in Vagrant file as well as edit add_hosts

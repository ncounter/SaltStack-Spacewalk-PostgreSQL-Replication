# SaltStack-Spacewalk-PostgreSQL-Replication

This project is a sample of Spacewalk installation and setup with a PostgreSQL replication solution implemented by PgPool-II and configured by SaltStack.

##Requirements

- one [minimal CentOS7](http://isoredirect.centos.org/centos/7/isos/x86_64/CentOS-7-x86_64-Minimal-1503-01.iso) machine: name this machine `spacewalk`
- two [openSuse 13.2](http://software.opensuse.org/132/en) machines: name these machines `postgres` and `postgres2` (names are setted for saltstack and pgpool-II configuration)
- [SaltStack](http://docs.saltstack.com/en/latest/topics/installation/index.html) installed on each machine (salt-minion on openSuse, salt-master and salt-minion on centOS)


```
                                      +---postgresql---+ 
                                      |                | 
                                      |  openSuse13.2  | 
                                  --->|  Salt-minion   | 
                                 |    |  Postgresql93  | 
          +----spacewalk----+    |    |                | 
          |                 |    |    +----------------+ 
          |     CentOs7     |    |                       
          |   Salt-master   |    |                       
          |   Salt-minion   |----|                       
          |    PgPool-II    |    |                       
          |    Spacewalk    |    |    +---postgresql2--+ 
          |                 |    |    |                | 
          +-----------------+    |    |  openSuse13.2  | 
                                 |    |  Salt-minion   | 
                                  --->|  Postgresql93  | 
                                      |                | 
                                      +----------------+ 
```


## SaltStack installation

This project uses SaltStack to configure the system.

On centOS, to install salt-minion and salt-master, run:
```
yum install salt-minion salt-master salt
```

On both openSuse, to install salt-minion, run:
```
zypper install salt-minion
```

For more details on installation and configuration of Salt see [the official installation docs](http://docs.saltstack.com/en/latest/topics/installation/index.html)


## Prepare the installation

Copy the `salt` folder in `/srv/` of the `spacewalk` machine (`/srv/salt` is the default SaltStack folder for states).


## PostgreSQL

From the salt-master, call the state to configure `postgresql` machines: this will install/configure PostgreSQL for Spacewalk setup.
```
salt 'postgresql*' state.highstate
```
<b>P.S.: Be sure to do this step before the "spacewalk state setup".</b>


## PgPool-II and Spacewalk

From the salt-master, call the state to configure the `spacewalk` machine: this will install/configure/start PgPool-II and Spacewalk.
```
salt 'spacewalk' state.highstate
```

## Run Spacewalk

Navigate in Spacewalk with [http://spacewalk](http://spacewalk).
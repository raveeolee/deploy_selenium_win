## Synopsis
Ansible scripts to manage selenium grid & nodes infrastracture. Please refer to [Ansible documentation](http://docs.ansible.com/) for details. 

Please make sure **Ansible** installed on your **master** machine. So you will need either linux machine with ansible installed or Windows 10 with developer mode enabled (not tested). 

## Ping
Pings inventory. Good for testing stuff. Use forks parameter to scale level of paralelisation. 

```
ansible all -i host -m win_ping --forks=8
```

## Reboot all hosts from inventory
Reboot all the hosts & make sure they are back again. 

```
ansible all -i host -m win_reboot --forks=8
```

Alternatively you can use aliases instead of *all* from from **host** file. Examples:


```
ansible nodes -i host -m win_ping // Will ping nodes only
``` 

```
ansible hub -i host -m win_ping   // Will ping hub only
```

## Start inventory

Will provision servers and run NODE or HUB depending on host description. Please refer to the [host](host) file.

```
ansible-playbook -i host up_grid_nodes.yml
```

## Run cleaning task
Deletes temp files from common windows places. Runs [Cleanup.ps1](files/Cleanup.ps1) script.

```
ansible-playbook -i host run_clean_script.yml 
```
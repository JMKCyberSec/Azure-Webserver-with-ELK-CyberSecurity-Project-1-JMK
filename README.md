# Azure-Webserver-with-ELK-CyberSecurity-Project-1-JMK

## Automated ELK Stack Deployment

The files in this repository were used to configure the network depicted below.

  [Elk-Network_Diagram](https://github.com/JMKCyberSec/Azure-Webserver-with-ELK-CyberSecurity-Project-1-JMK/blob/main/Diagrams/XCorpTandT_Net_Diagram_with_ELK.pdf)

These files have been tested and used to generate a live ELK deployment on Azure. They can be used to recreate the entire deployment pictured above. Alternatively, select ansible-playbook files may be used to install only certain pieces of it, such as Filebeat. Below are the 4 playbooks in order of deployment when building and configuring the Network above. 

  [DVWAPlaybook.yml](https://github.com/JMKCyberSec/Azure-Webserver-with-ELK-CyberSecurity-Project-1-JMK/blob/main/Ansible/playbooks/DVWAPlaybook.yml)
  
  [ELKplaybook.yml](https://github.com/JMKCyberSec/Azure-Webserver-with-ELK-CyberSecurity-Project-1-JMK/blob/main/Ansible/playbooks/ELKplaybook.yml)
  
  [Filebeatplaybook.yml](https://github.com/JMKCyberSec/Azure-Webserver-with-ELK-CyberSecurity-Project-1-JMK/blob/main/Ansible/playbooks/filebeatplaybook.yml)
  
  [Metricbeatplaybook.yml](https://github.com/JMKCyberSec/Azure-Webserver-with-ELK-CyberSecurity-Project-1-JMK/blob/main/Ansible/playbooks/metricbeatplaybook.yml)

This document contains the following details:
- Description of the Topology
- Access Policies
- ELK Configuration
  - Beats in Use
  - Machines Being Monitored
- How to Use the Ansible Build


### Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the D*mn Vulnerable Web Application.

Load balancing ensures that the application will be highly available, in addition Load Balancers help to prevent server overloads. Utilization of the Jump-Box ensures access to the network is restricted to one authorized machine from one IP address and with a set of asymmetrical keys. For the purposes of this setup, we only opened access to the DVWA from our home IP address but if you wanted to make this publically available, you would want to change the Azure Network Security Rule to allow "any" sources. Access to the DVWA is made possible by nagvigating to ip address 20.97.166.11.  

Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the system files and evaluate system statistics.

The configuration details of each machine may be found below.

| Name         | Function        | Internal IP Address | Public Ip Address  | Operating System           |
|--------------|-----------------|---------------------|--------------------|----------------------------|
| Jump-Box     | Gateway         | 10.0.0.4            | 20.97.168.124      | Linux                      |
| Web-1        | Webserver DVWA  | 10.0.0.5            | 20.97.166.11 *     | Linux w/ Docker Container  |
| Web-2        | Webserver DVWA  | 10.0.0.6            | 20.97.166.11 *     | Linux w/ Docker Container  |
| Web-3        | Webserver DVWA  | 10.0.0.7            | 20.97.166.11 *     | Linux w/ Docker Container  |
| ELK-Stack VM | Monitor/Logging | 10.1.0.4            | 20.94.216.169:5601 | Linux w/ Docker Container  |
  * This is the ip address of the load balancer. Web-1,-2,-3 do not inherently have a public ip address. 

### Access Policies

The machines on the internal network are not exposed to the public Internet. 

Only the Jump-Box machine (public IP address 20.97.168.124) can accept ssh connections from the Internet. To ensure the ssh connections are secure, we utilized asymmetrical keys for sign-in/authentication. Access to the Jump-box is only allowed from the authorized host desktop machine from the following public IP address -  173.***.***.***

Machines within the network can only be accessed by the Jump-Box VM (Private IP address 10.0.0.4) utilizing connection to a docker container which incorporates a unique set of asymmetrical keys to ssh to each individual server (Web-1, Web-2, Web-3, ELK-Stack. (Keys differ from the initial Authorized Host Machine to the Jump-Box keys)

A summary of the access policies in place can be found in the table below.

| Name          | Publicly Accessible  | Public     --IP Addresses--    Private  | Allowed by; IP Address:Port |
|---------------|----------------------|-----------------------------------------|-----------------------------|
| Jump-Box      |     No/Restricted    | 20.97.168.124                  10.0.0.4 |          173.XXX.XXX.XXX:22 |
| Load-Balancer |     No/Restricted    | 20.97.166.11:80           No Private IP |          173.XXX.XXX.XXX:80 |
| Web-1         |          No          | No Public IP                   10.0.0.5 |         (LB - 20.97.166.11) |
| Web-2         |          No          | No Public IP                   10.0.0.6 |         (LB - 20.97.166.11) |
| Web-3         |          No          | No Public IP                   10.0.0.7 |         (LB - 20.97.166.11) |
| ELK-Stack     |     No/Restricted    | 20.94.216.169                  10.1.0.4 |        173.XXX.XXX.XXX:5601 |


### Target Machines & Beats
This ELK server is configured to monitor the following machines:
| Name        | Private IP Address |
|-------------|--------------------|
| Web-1 DVWA  | 10.0.0.5           |
| Web-2 DVWA  | 10.0.0.6           |
| Web-3 DVWA  | 10.0.0.7           |

We have installed the following Beats on these machines:
| Name       | Private IP Address | Filebeat  | Metricbeat |
|------------|--------------------|-----------|------------|
| Web-1 DVWA | 10.0.0.5           | Installed | Installed  |
| Web-2 DVWA | 10.0.0.6           | Installed | Installed  |
| Web-3 DVWA | 10.0.0.7           | Installed | Installed  |

These Beats allow us to collect the following information from each machine:
- ... Filebeat allows us to collect system log information from each of the machines. We are able to see a wide array of log info including items such as log-in       attempts, sudo use, user additions or changes, and other logs.
- ... Metricbeat allows us to send data that is collected and put it into a specified output to make it more understandable. We are able to view all types of           metrics from CPU usage to Memory Utilization, Uptime, Internet Traffic Flow, Traffic Source and Destinations and a great deal more.  


### Azure Configuration 

It is a good idea to generate a key pair on your host machine to prepare you for the Azure environment setup. To create the key, run the following commands in the Command Line on your host machine and then copy the SSH key string to your clipboard. When you create the VM's in Azure, you can paste the key into the use existing key field. 
   -  `ssh-keygen`
   -  `cat ~/.ssh/id_rsa.pub` 
   -  This key you will use to log into your Jump-Box and you can use it while setting up your other VM's. However, you will need to generate a different set of keys in your ansible container that resides inside your Jump-Box VM once you get the container installed for Web-1, Web-2, Web-3, and ELKStack VM's. This increases security of the Azure environment by utilizing two different set of keys. Navagation to each VM in the Azure Web Portal and scrolling down in the menu to password reset will be required once the container is up and running and the second set of keys are generated inside the container. 
   
   -  [See Azure Reset Password image](https://github.com/JMKCyberSec/Azure-Webserver-with-ELK-CyberSecurity-Project-1-JMK/blob/main/Images/AzureVMresetPassword.png) 


We used Microsoft Azure to build our virtual environment. The following Azure resources were created and utilized;
- 1). Resource Group - ResourceGroupA, region: East US 2.  All resources were contained inside this resource group
- 2). Virtual Network 1 of 2 - JMKCyberSecVNetA, region: East US 2, ip addresses: default, DDoS Protection: DISABLE.
- 3). Network Security Group (NSG) 1 of 2 - JMKCSVNSG, region: East US 2, created with an initial DENY ALL security rule.
- 4). Virtual Machine 1 of 5 - Jump-Box, region: East US 2, size: B1s, must have public IP.
- 5). Virtual Machine 2 of 5 - Web-1, region: East US 2, size: B1ms, must NOT have a public IP.
- 6). Virtual Machine 3 of 5 - Web-2, region: East US 2, size: B1ms, must NOT have a public IP.
- 7). Virtual Machine 4 of 5 - Web-3, region: East US 2, size: B1ms, must NOT have a public IP. 
- 8). Load Balancer - LoadBalancer_JMK1
      - Add a Health Probe - JMK_Health_Probe: TCP Protocol, port 80.
      - Add a Backend Pool - JMK_BackendPool: add Web-1 Web-2 and Web-3 to it. 
      - Add a Load Balancing Rule - JMK_LoadBalance_Rule1: TCP, to allow port 80, backend port 80 as well, select your Health Probe and Backend Pool, Client IP and Protocol Persistance.
- 9). Virtual Network 2 of 2 - ELKVNet, region: West US 2, IP Addresses: default, DDoS Protection: DISABLE.
      - Peering - Create a peer connection between your 2 Virtual Networks (since your VNets are located in different regions).
- 10). Network Security Group (NSG) 2 of 2 - ELKStackNSG, region: West US 2.
- 11). Virtual Machine 5 of 5 - ELKStack, region: West US 2, size: B2s (must be minimum 4GB RAM) must have a public IP.

You will need a few Inbound Security Rules in place;
- Navigate to your Azure Web Portal Network Security Group. 
  - Create an Inbound Rule AllowSSH - Source: Ip Address "home public IP", Source port: *, Destination: VNet, Service: SSH, Dest Port: 22, Protocol: TCP, ALLOW
  - Create an Inbound Rule AllowJumptoVNet - Source: IP Address 10.0.0.4, Source port: *, Destination VNet, Service: SSH, Dest Port: 22, Protocol: TCP, ALLOW 


### Ansible/Docker Container Configuration 

One of the most critical components of this system is the Ansible Docker Container we use to add an additional step to the login-process of accessing our Azure environment system files. Below you will find commands that guide you through the process.
- Start by installing docker.io on the Jump-Box;
   - Run `sudo apt update` - this will discover what updates are available. 
   - Run `sudo apt install docker.io` - this will install the most currect docker.io
   - Run `sudo systemctl status docker` - run this to confirm that docker is if it is not run `sudo systemctl start docker`
   - Run `sudo docker pull cyberxsecurity/ansible` - this will pull the cyberxsecurity/ansible container.
   - Run `sudo docker run -ti cyberxsecurity/ansible:latest bash` - this will start the container for the initial run, do not use this to subsequently start the container (it will build a new container). 
   - Using your Command line logged into your Jump-Box run `sudo docker container list -a` to list you containers and see your container name, take note. 
   - Run `sudo docker start "yourcontainer_name"` - This starts the container.
   - Run `sudo docker attach "yourcontainer_name"` - This logs you into your container.
   - Run `ssh-keygen` to create the new SSH key that you will use for Web-1 Web-2 Web-3 and ELKStack. 
   - Run `cat .ssh/id_rsa.pub` - this will output the public key. You will want to copy it to your clipboard.
   - Go back to you Azure Web Portal and change Web-1 Web-2 Web-3 and ELKStack VM's password. Choose "Use existing key".
   - Paste the public key from your clipboard into the appropriate field. Click Save and confirm the key has changed in notifications.
   - Go back to your command line and verify you can ssh into each VM. 
   - From your container Run `ssh azadmin@10.0.0.5` - this will log you into Web-1 (Note: your username and IP may differ)
   - Run `exit`
   - From your container Run `ssh azadmin@10.0.0.6` - this will log you into Web-1 (Note: your username and IP may differ)
   - Run `exit`    
   - From your container Run `ssh azadmin@10.0.0.7` - this will log you into Web-1 (Note: your username and IP may differ)
   - Run `exit`
   - From your container Run `ssh ELKadmin@10.1.0.4` - this will log you into Web-1 (Note: your username and IP may differ)
   - Run `exit`
   - Run `cd /etc/ansible` - This will navigate you into the Containers /etc/ansible folder.
   - Run `ls` = this will list the contents and you should verify that you have a hosts file and an ansible.cfg file. 
   - The /etc/ansible/hosts file should match (IP addresses may differ) [this hosts file;](https://github.com/JMKCyberSec/Azure-Webserver-with-ELK-CyberSecurity-Project-1-JMK/blob/main/Ansible/hosts)
      Feel free to copy and paste the contents or edit your existing file to match. 
   - The /etc/ansible/ansible.cfg file should match (Usernames and IP addresses may differ) [this ansible.cfg file;](https://github.com/JMKCyberSec/Azure-Webserver-with-ELK-CyberSecurity-Project-1-JMK/blob/main/Ansible/ansible.cfg)
      Feel free to copy and paste the contents or edit your existing filr to match.
      * Please note, we have already edited the hosts and ansible.cfg files to accommodate the ELKStack server. 
   - Download and locate the following playbook.yml file in /etc/ansible directory:
     [DVWAPlaybook.yml File](https://github.com/JMKCyberSec/Azure-Webserver-with-ELK-CyberSecurity-Project-1-JMK/blob/main/Ansible/playbooks/DVWAPlaybook.yml)  
   - While in the /etc/ansible directory Run `ansible-playbook DVWAPlaybook.yml` - this will build the DVWA Containers on Web-1 Web-2 and Web-3.
   - SSH into Web-1 We-2 and Web-3 and Run `curl localhost/setup.php` verify that <html> code was returned for each VM. 
   - Go back the the Azure Web Portal and nagigate to the Network Security Group. 
   - Go to Inbound Rules and click "ADD". 
   - Configure a rule that allows your public IP address from your host machine to access the Virtual Network via port 80 use "Any" Protocol. 
   - Delete the rule to Deny All Inbound traffic.   
      
### Elk Configuration

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which is advantageous because additional VM's or entire environments can be brought online very quickly and with few, if any, issues.

The ELKPlaybook.yml is an ansible playbook that implements the following tasks:
- ... Installs docker.io and pip3 
- ... Utilizes pip3 to run python scripts
- ... Expands the memory for a more stable environment
- ... Downloads and configures the following ELK Docker Container Image: sebp/elk:761
- ... Enables docker service upon boot

To Install the Monitoring System onto the ELKStack run the following commands;
  - Run `cd /etc/ansible`  - this places you into the /etc/ansible directory. 
  - Copy the contents of the provided ELKplaybook.yml onto your clipboard
  - Run `nano ELKplaybook.yml` - This creates and opens ELKplaybook.yml in nano. Paste the contents into the Nano file. Hit "Ctl+X" - "Y" - "ENTER"
  - Run `ansible-playbook ELKplaybook.yml` - This installs the container on the ELKStack VM and logs you into the container.
  - Run `ssh elkadmin@10.1.0.4`
  - Run `docker ps` - this step allows you to verify that the sebp/elk:761 container is running.
     The following screenshot displays the result of running `docker ps` after successfully configuring the ELK instance 
     [Screenshot](https://github.com/JMKCyberSec/Azure-Webserver-with-ELK-CyberSecurity-Project-1-JMK/blob/main/Images/docker_ps.png) 
  - Go to your Azure Web portal. Navigate to your ELKStackNSG and click on "inbound rules". Click "ADD".
  - Create a rule that allows TCP traffic from your home public IP address to the ELKStack public ip address on port 5601.
  - Verify you have access by opening a browser and navigating to http://[yourELKStackpublicip]:5601/app/kibana 
  
  
### Using the Filebeat and Metricbeat playbook
In order to use the playbook, you will need to have an Ansible control node already configured. Assuming you have such a control node provisioned: 

SSH into the control node and follow the steps below:
- Copy the playbook.yml file to /etc/ansible/roles/filebeatplaybook.yml. (you may need to `mkdir roles` inside the ansible directory.)
  [Filebeat Playbook File:](https://github.com/JMKCyberSec/Azure-Webserver-with-ELK-CyberSecurity-Project-1-JMK/blob/main/Ansible/playbooks/filebeatplaybook.yml)
- Copy the playbook.yml file to /etc/ansible/roles/metricbeatplaybook.yml. 
  [Metricbeat Playbook File:](https://github.com/JMKCyberSec/Azure-Webserver-with-ELK-CyberSecurity-Project-1-JMK/blob/main/Ansible/playbooks/metricbeatplaybook.yml)
- Update the hosts file to include any of the VM's you want to install the Filebeat utility on.   
   - [webservers]
   - 10.0.0.5 ansible_python_interpreter=/usr/bin/python3
   - 10.0.0.6 ansible_python_interpreter=/usr/bin/python3
   - 10.0.0.7 ansible_python_interpreter=/usr/bin/python3
- Download the following files and locate them in the /etc/ansible/files directory (you may need to `mkdir files` in the /etx/ansible directory).
  
  1). [Filebeat Config file](https://github.com/JMKCyberSec/Azure-Webserver-with-ELK-CyberSecurity-Project-1-JMK/blob/main/Ansible/filebeat-config.yml)
  
  2). [Metricbeat Config file](https://github.com/JMKCyberSec/Azure-Webserver-with-ELK-CyberSecurity-Project-1-JMK/blob/main/Ansible/metricbeat-config.yml)  
    - Edit the /etc/ansible/files/filebeat-config.yml with the following edits; (you will enter your IP address example: 10.1.0.4) 
      [See filebeat edits image](https://github.com/JMKCyberSec/Azure-Webserver-with-ELK-CyberSecurity-Project-1-JMK/blob/main/Images/Filebeatconfig_edits.png)  
    - Edit the /etc/ansible/files/metricbeat-config.yml with the following edits; (you will enter your IP address example: 10.1.0.4)
      [See metricbeat edits image](https://github.com/JMKCyberSec/Azure-Webserver-with-ELK-CyberSecurity-Project-1-JMK/blob/main/Images/Metricbeatconfig_edits.png)
  
- Run the playbook, and navigate to Kibana to verify that the installation worked as expected.
- In your web browser enter `https://[your.elkstack.public.ip]:5601/app/kibana. 
- Confirm that Kibana loads on your browser. 

**** FAQ's
- _Which file is the playbook? Ansible playbook files end in '.yml'. Playbook files used for this system are as follows;
   - DVWAPlaybook.yml         (Builds the DVWA web application on specified machines)
   - ELKplaybbok.yml          (Builds the ELK application onto the specified ELK Server)
   - filebeatplaybook.yml     (Installs the filebeat application onto the DVWA Servers)
   - metricbeatplaybook.yml   (Installs the metricbeat application onto the DVWA Servers)

- _Which file do you update to make Ansible run the playbook on a specific machine? You update the /etc/ansible/hosts file and you can call out different groups    in which the playbook will look for to know what machines to run the playbook on. 
             [See Ansible hosts image](https://github.com/JMKCyberSec/Azure-Webserver-with-ELK-CyberSecurity-Project-1-JMK/blob/main/Images/Ansible_hosts.png) 

- _How do I specify which machine to install the ELK server on versus which to install Filebeat on? In the playbook file in the very first section on line 3 it      calls out which host to look for to run the playbook on. 
             [See which host image](https://github.com/JMKCyberSec/Azure-Webserver-with-ELK-CyberSecurity-Project-1-JMK/blob/main/Images/playbook_which_host.png) 
                 You edit that line to either webservers or elk in this scenario. (You have at this point already defined what machines are in the webservers                      group and what machines are in the elk group. 
- _Which URL do you navigate to in order to check that the ELK server is running? http://20.94.216.169:5601/ 

*** If you would like to install an ELK server onto you system I have provided the following commands that you will utilize when installing the files in this repository. 
- 
**** Here is a list of the common commands you will utilize during this setup;
- SSH
  `ssh [yourusername]@[your.vm.ip.address]` - this will log you into your VM's from the command line.
  `ssh-keygen` - This will generate an asymmetrical key pair (1 public and 1 private).
  `cat ~/.ssh/id_rsa.pub - this will display your public key which you will copy and paste into the Azure Web Portal for your VM's.
  
- apt 
  `sudo apt update` - This discovers any available updates to your Ubuntu OS.
  `sudo apt upgrade` - This installs any available updates to your Ubuntu OS. 
  `sudo apt install docker.io` - This installs docker onto the machine you run the command on. (This is installed on your Jump-Box manually with this command) 

- docker
  `sudo systemctl status docker` - This check if docker is running.
  `sudo systemctl start docker` - This starts docker on your system if you need to start it. 
  `sudo docker pull cyberxsecurity/ansible` - This will pull the Docker container from the repo to your machine.
  `sudo docker run -ti cyberxsecurity/ansible:latest bash` - this will start the container for the initial run, only use this command once. 
  `sudo docker container list -a - this will list your docker container(s) details. 
  `sudo docker start [container_name]` - This will start your container.
  `sudo docker attach [container_name]` - This will log you into your container.
  `sudo docker ps` - this will display your container info that you are currently logged-in to. 
  `sudo docker stop` - this will stop a container (similar to shutting down a VM).
  `exit` - This will log you out or exit you from the ssh connections or from your docker container. 
  
- ansible
  `ansible-playbook [your_playbook_name.yml]` - this will execute or run your playbook. 
  `nano [your_playbook_name.yml]` - This will open your playbook (or create it if it doesnt exist) for editing. 
  `ansible all -m ping` - this will ping the VM's that exist in the "/etc/ansible/hosts" file. 
  
- curl
  `curl [url to files on github] - this is a tried and tested way to get files from the web into various VM's. 
  `curl localhost/setup.php` - This tests the connection and the DVWA container. It should return <html> and that indicates it is working properly. 
  
- general cmd
  `ls`
  `mv`
  `cd`
  `ls -la`
  `nano`
  `exit`
  `cp`
  
  
  

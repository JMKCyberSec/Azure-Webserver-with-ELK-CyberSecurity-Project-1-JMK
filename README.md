# Azure-Webserver-with-ELK-CyberSecurity-Project-1-JMK

## Automated ELK Stack Deployment

The files in this repository were used to configure the network depicted below.

[ https://github.com/JMKCyberSec/Azure-Webserver-with-ELK-CyberSecurity-Project-1-JMK/blob/main/Diagrams/XCorpTandT_Net_Diagram_with_ELK.pdf ] (Azure-Webserver-with-ELK-CyberSecurity-Project-1-JMK/Diagrams/XCorpTandT_Net_Diagram_with_ELK.pdf) 

These files have been tested and used to generate a live ELK deployment on Azure. They can be used to recreate the entire deployment pictured above. Alternatively, select ansible-playbook files may be used to install only certain pieces of it, such as Filebeat. Below are the 4 playbooks in order of deployment when building and configuring the Network above. 

   - https://github.com/JMKCyberSec/Azure-Webserver-with-ELK-CyberSecurity-Project-1-JMK/blob/main/Anisble/playbooks/DVWAPlaybook.yml
   - https://github.com/JMKCyberSec/Azure-Webserver-with-ELK-CyberSecurity-Project-1-JMK/blob/main/Anisble/playbooks/ELKplaybook.yml 
   - https://github.com/JMKCyberSec/Azure-Webserver-with-ELK-CyberSecurity-Project-1-JMK/blob/main/Anisble/playbooks/filebeatplaybook.yml
   - https://github.com/JMKCyberSec/Azure-Webserver-with-ELK-CyberSecurity-Project-1-JMK/blob/main/Anisble/playbooks/metricbeatplaybook.yml

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

It is a good idea to run the following commands in the Command Line on your host machine and then copy the SSH key string to your clipboard. When you create the VM's in Azure, you can paste the key into the use existing key field. 
   -  `ssh-keygen`
   -  `cat ~/.ssh/id_rsa.pub` 
   -  This key you will use to log into your Jump-Box and you can use it while setting up your other VM's however, you will need to generate a different set of keys in your ansible container that resides inside your Jump-Box VM once you get the container installed for Web-1, Web-2, Web-3, and ELKStack VM's. Navagation to each VM in the Azure Web Portal and scrolling down in the menu to password reset will be required once the container is up and running. 
   -  See image: https://github.com/JMKCyberSec/Azure-Webserver-with-ELK-CyberSecurity-Project-1-JMK/blob/main/Images/AzureVMresetPassword.png 


We used Microsoft Azure to build our virtual environment. The following Azure resources were created.
- 1). Resource Group - ResourceGroupA, region: East US 2.  All resources were contained inside this resource group
- 2). Virtual Network 1 of 2 - JMKCyberSecVNetA, region: East US 2, ip addresses: default, DDoS Protection: DISABLE.
- 3). Network Security Group (NSG) - JMKCSVNSG, region: East US 2, created with an initial DENY ALL security rule.
- 4). Virtual Machine 1 of 5 - Jump-Box, region: East US 2, size: B1s, must have public IP.
- 5). Virtual Machine 2 of 5 - Web-1, region: East US 2, size: B1ms, must NOT have a public IP.
- 6). Virtual Machine 3 of 5 - Web-2, region: East US 2, size: B1ms, must NOT have a public IP.
- 7). Virtual Machine 4 of 5 - Web-3, region: East US 2, size: B1ms, must NOT have a public IP. 
- 8). Load Balancer
      - Add a Health Probe TCP Protocol, port 80.
      - Add a Backend Pool and add Web-1 Web-2 and Web-3 to it. 
      - Add a Load Balancing Rule TCP, to allow port 80, backend port 80 as well, select your Health Probe and Backend Pool, Client IP and Protocol Persistance.
- 9). Virtual Network 2 of 2 - ELKVNet, region: West US 2, IP Addresses: default, DDoS Protection: DISABLE.
      - Peering - Create a peer connection between your 2 Virtual Networks (since your VNets are located in different regions).
- 10). Virtual Machine 5 of 5 - ELKStack, region: West US 2, size: B2s (must be minimum 4GB RAM) must have a public IP.







### Ansible/Docker Container Configuration 

### Elk Configuration

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which is advantageous because additional VM's or entire environments can be brought online very quickly and with few, if any, issues.

The ELKPlaybook.yml is an ansible playbook that implements the following tasks:
- ... Installs docker.io and pip3 
- ... Utilizes pip3 to run python scripts
- ... Expands the memory for a more stable environment
- ... Downloads and configures the following ELK Docker Container Image: sebp/elk:761
- ... Enables docker service upon boot

The following screenshot displays the result of running `docker ps` after successfully configuring the ELK instance.

https://github.com/JMKCyberSec/Azure-Webserver-with-ELK-CyberSecurity-Project-1-JMK/blob/main/Images/docker_ps.png


### Using the Playbook
In order to use the playbook, you will need to have an Ansible control node already configured. Assuming you have such a control node provisioned: 

SSH into the control node and follow the steps below:
- Copy the playbook.yml file to /etc/ansible/roles/filebeatplaybook.yml.
- Update the hosts file to include any of the VM's you want to install the Filebeat utility on.
   - [webservers]
   - 10.0.0.5 ansible_python_interpreter=/usr/bin/python3
   - 10.0.0.6 ansible_python_interpreter=/usr/bin/python3
   - 10.0.0.7 ansible_python_interpreter=/usr/bin/python3
- Run the playbook, and navigate to Kibana to verify that the installation worked as expected.

**** FAQ's
- _Which file is the playbook? Ansible playbook files end in '.yml'. Playbook files used for this system are as follows;
   - DVWAPlaybook.yml         (Builds the DVWA web application on specified machines)
   - ELKplaybbok.yml          (Builds the ELK application onto the specified ELK Server)
   - filebeatplaybook.yml     (Installs the filebeat application onto the DVWA Servers)
   - metricbeatplaybook.yml   (Installs the metricbeat application onto the DVWA Servers)

- _Which file do you update to make Ansible run the playbook on a specific machine? You update the /etc/ansible/hosts file and you can call out different groups    in which the playbook will look for to know what machines to run the playbook on. 
             See image: https://github.com/JMKCyberSec/Azure-Webserver-with-ELK-CyberSecurity-Project-1-JMK/blob/main/Images/Ansible_hosts.png 

- _How do I specify which machine to install the ELK server on versus which to install Filebeat on? In the playbook file in the very first section on line 3 it      calls out which host to look for to run the playbook on. 
             See image: https://github.com/JMKCyberSec/Azure-Webserver-with-ELK-CyberSecurity-Project-1-JMK/blob/main/Images/playbook_which_host.png 
                 You edit that line to either webservers or elk in this scenario. (You have at this point already defined what machines are in the webservers                      group and what machines are in the elk group. 
- _Which URL do you navigate to in order to check that the ELK server is running? http://20.94.216.169:5601/ 

*** If you would like to install an ELK server onto you system I have provided the following commands that you will utilize when installing the files in this repository. 
- 

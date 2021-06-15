# Azure-Webserver-with-ELK-CyberSecurity-Project-1-JMK

## Automated ELK Stack Deployment

The files in this repository were used to configure the network depicted below.

[ https://github.com/JMKCyberSec/Azure-Webserver-with-ELK-CyberSecurity-Project-1-JMK/blob/main/Diagrams/XCorpTandT_Net_Diagram_with_ELK.pdf ] (Azure-Webserver-with-ELK-CyberSecurity-Project-1-JMK/Diagrams/XCorpTandT_Net_Diagram_with_ELK.pdf) 

These files have been tested and used to generate a live ELK deployment on Azure. They can be used to recreate the entire deployment pictured above. Alternatively, select portions of the anisble-playbook file may be used to install only certain pieces of it, such as Filebeat. Below are the 4 playbooks in order of deployment when building and configuring the Network above. 

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

Load balancing ensures that the application will be highly available, in addition to restricting access to the network.

Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the system files and system statistics.

The configuration details of each machine may be found below.

| Name         | Function        | IP Address | Operating System           |
|--------------|-----------------|------------|----------------------------|
| Jump-Box     | Gateway         | 10.0.0.4   | Linux                      |
| Web-1        | Webserver DVWA  | 10.0.0.5   | Linux w/ Docker Container  |
| Web-2        | Webserver DVWA  | 10.0.0.6   | Linux w/ Docker Container  |
| Web-3        | Webserver DVWA  | 10.0.0.7   | Linux w/ Docker Container  |
| ELK-Stack VM | Monitor/Logging | 10.1.0.4   | Linux w/ Docker Container  |

### Access Policies

The machines on the internal network are not exposed to the public Internet. 

Only the Jump-Box machine (public IP address 20.97.168.124) can accept ssh connections from the Internet. To ensure the ssh connections are secure, we utilized asymmetrical keys for sign-in/authentication. Access to the Jump-box is only allowed from the authorized host desktop machine from the following public IP address -  173.20.35.5

Machines within the network can only be accessed by the Jump-Box VM (Private IP address 10.0.0.4) utilizing connection to a docker container which incorporates a unique set of asemmertical keys to ssh to each individual server. (Keys differ from the initial Authorized Host Machine to the Jump-Box keys)

A summary of the access policies in place can be found in the table below.

| Name                   | Publicly Accessible     | Allowed IP Addresses | Allow Port 80 IP Adresses | Allow Port 5601 Ip Addresses |
|------------------------|-------------------------|----------------------|---------------------------|------------------------------|
| Jump-Box               | No/Restricted via ssh   | 173.20.35.5          | Not Allowed               | Not Allowed                  |
| Web-1 System           | No/Restricted           | 10.0.0.4             | Yes / 173.20.35.5         | Not Allowed                  |
| Web-2 System           | No/Restricted           | 10.0.0.4             | Yes / 173.20.35.5         | Not Allowed                  |
| Web-3 System           | No/Restricted           | 10.0.0.4             | Yes / 173.20.35.5         | Not Allowed                  |
| ELK Monitoring Server  | No/Restricted           | 10.0.0.4             | Not Allowed               | Yes / 173.20.35.5            |

### Elk Configuration

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which is advantageous because additional VM's or entire environments can be brought online very quickly and with few, if any issues.

The ELKPlaybook.yml is a ansible playbook that implements the following tasks:
- ... Installs docker.io and pip3 
- ... Utilizes pip3 to run python scripts
- ... Expands the memory for a more stable environment
- ... Downloads and configures the following ELK Docker Container Image: sebp/elk:761
- ... Enables docker service upon boot

The following screenshot displays the result of running `docker ps` after successfully configuring the ELK instance.

https://github.com/JMKCyberSec/Azure-Webserver-with-ELK-CyberSecurity-Project-1-JMK/blob/main/Images/docker_ps.png

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

### Using the Playbook
In order to use the playbook, you will need to have an Ansible control node already configured. Assuming you have such a control node provisioned: 

SSH into the control node and follow the steps below:
- Copy the playbook.yml file to /etc/ansible/roles/filebeatplaybook.yml.
- Update the hosts file to include any of the VM's you want to install the filebeat utility on.
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

If you would like to install an ELK server onto you system I have provided the following step by step directions utilizing the files in this repository. 

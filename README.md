# Azure-Webserver-with-ELK-CyberSecurity-Project-1-JMK

## Automated ELK Stack Deployment

The files in this repository were used to configure the network depicted below.

[ https://github.com/JMKCyberSec/Azure-Webserver-with-ELK-CyberSecurity-Project-1-JMK/blob/main/Diagrams/XCorpTandT_Net_Diagram_with_ELK.pdf ] (Azure-Webserver-with-ELK-CyberSecurity-Project-1-JMK/Diagrams/XCorpTandT_Net_Diagram_with_ELK.pdf) 

These files have been tested and used to generate a live ELK deployment on Azure. They can be used to either recreate the entire deployment pictured above. Alternatively, select portions of the anisble-playbook file may be used to install only certain pieces of it, such as Filebeat.

   - https://github.com/JMKCyberSec/Azure-Webserver-with-ELK-CyberSecurity-Project-1-JMK/blob/main/Anisble/playbooks/ELKplaybook.yml 

This document contains the following details:
- Description of the Topologu
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

Only the Jump-Box machine (public IP address 20.97.168.124) can accept ssh connections from the Internet. To ensure the ssh connections are secure, we utilized asymmetrical keys for sign-in/authentication. Access to the Jump-box is only allowed from an authorized host desktop machine from the following IP address:
- 173.20.35.5

Machines within the network can only be accessed by the Jump-Box VM (Private IP address 10.0.0.4) utilizing sign-in to a docker container which incorporates a unique set of asemmertical keys to ssh to each individual server.

A summary of the access policies in place can be found in the table below.

| Name                   | Publicly Accessible  | Allowed IP Addresses |
|------------------------|----------------------|----------------------|
| Jump-Box               | Restricted via ssh   | 173.20.35.5          |
| Web-1 DVWA             | Restricted           | 173.20.35.5          |
| Web-2 DVWA             | Restricted           | 173.20.35.5          |
| Web-3 DVWA             | Restricted           | 173.20.35.5          |
| ELK Monitoring Server  | Restricted port 5601 | 173.20.35.5          |

### Elk Configuration

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which is advantageous because additional VM's or entire environments can be brought online very quickly and with few, if any issues.

The ELKPlaybook.yml is a ansible playbook that implements the following tasks:
- ... Installs docker.io and pip3 
- ... Utilizes pip3 to run python scripts
- ... Expands the memory for a more stable environment
- ... Downloads and configures the following ELK Docker Container Image: sebp/elk:761
- ... Enables docker service upon boot

The following screenshot displays the result of running `docker ps` after successfully configuring the ELK instance.

![TODO: Update the path with the name of your screenshot of docker ps output](Images/docker_ps_output.png)

### Target Machines & Beats
This ELK server is configured to monitor the following machines:
- _TODO: List the IP addresses of the machines you are monitoring_

We have installed the following Beats on these machines:
- _TODO: Specify which Beats you successfully installed_

These Beats allow us to collect the following information from each machine:
- _TODO: In 1-2 sentences, explain what kind of data each beat collects, and provide 1 example of what you expect to see. E.g., `Winlogbeat` collects Windows logs, which we use to track user logon events, etc._

### Using the Playbook
In order to use the playbook, you will need to have an Ansible control node already configured. Assuming you have such a control node provisioned: 

SSH into the control node and follow the steps below:
- Copy the _____ file to _____.
- Update the _____ file to include...
- Run the playbook, and navigate to ____ to check that the installation worked as expected.

_TODO: Answer the following questions to fill in the blanks:_
- _Which file is the playbook? Where do you copy it?_
- _Which file do you update to make Ansible run the playbook on a specific machine? How do I specify which machine to install the ELK server on versus which to install Filebeat on?_
- _Which URL do you navigate to in order to check that the ELK server is running?

_As a **Bonus**, provide the specific commands the user will need to run to download the playbook, update the files, etc._

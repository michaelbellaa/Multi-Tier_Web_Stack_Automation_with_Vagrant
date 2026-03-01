# Multi-Tier_Web_Stack_Automation_with_Vagrant
This project automates the deployment of a complete 5-tier web application stack using Vagrant and Shell Scripting. The infrastructure is designed to be highly modular, simulating a production-like environment where 
each service runs on a dedicated virtual machine.

# Architecture Components
The environment consists of five specialized Virtual Machines (VMs) communicating over a private network:
Hostname	  Role	                      OS	                   IP Address	         RAM
web01	      Nginx (Load Balancer)	      Ubuntu 22.04	         192.168.56.11	     1024 MB
app01	      Tomcat (App Server)	        CentOS Stream 9	       192.168.56.12	     2048 MB
rmq01	      RabbitMQ (Broker)	          CentOS Stream 9	       192.168.56.13	     1024 MB
mc01	      Memcached (Cache)	          CentOS Stream 9	       192.168.56.14	     1024 MB
db01	      MariaDB (Database)	        CentOS Stream 9	       192.168.56.15	     1024 MB

# Key Features:
Service Discovery: Integrated vagrant-hostmanager to automatically update /etc/hosts on all nodes.

Automated Provisioning: Idempotent shell scripts for zero-touch configuration.

Hybrid OS Support: Seamlessly orchestrates both Debian (Ubuntu) and RHEL (CentOS) based systems.

# Prerequisites
[Download VirtualBox](https://www.virtualbox.org/wiki/Downloads)

[Install Vagrant](https://developer.hashicorp.com/vagrant/install)

The hostmanager plugin: vagrant plugin install vagrant-hostmanager.

# Deployment
1.Clone the repository:
git clone https://github.com/michaelbellaa/Multi-Tier_Web_Stack_Automation_with_Vagrant.git
cd Multi-Tier_Web_Stack_Automation_with_Vagrant

2.Provision the stack:
# This will download boxes, configure networking, and run all scripts
vagrant up

3.Verify Services:
You can access the application via the Load Balancer IP: http://192.168.56.11 .

# Repository Structure
├── Vagrantfile            # Infrastructure definition (VM specs, Networking)
├── scripts/               # Automated provisioning logic
│   ├── mysql.sh           # MariaDB setup and schema migration
│   ├── memcache.sh        # Caching layer configuration
│   ├── rmq.sh        # Message broker setup
│   ├── tomcat.sh          # Java environment and App deployment
│   └── nginx.sh           # Reverse proxy and LB configuration
└── README.md

# Automation Details
Each component is provisioned via specific shell scripts located in the scripts/ directory. These scripts handle:
Updating system packages.
Installing required dependencies (Java, GCC, etc.).
Managing service ports and firewall settings.
Configuring application-specific configuration files (e.g., nginx.conf, my.cnf).

# Author
Michael Ayoub Bella

LinkedIn: https://www.linkedin.com/in/michael-ayoub-85617a281/

Portfolio: https://github.com/michaelbellaa

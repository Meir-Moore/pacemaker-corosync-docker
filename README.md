## pacemaker-corosync-docker
This repository contains a Docker-based setup for managing a multi-node cluster with Pacemaker and Corosync. The project includes configurations for Apache, MySQL, and Jenkins, showcasing automated cluster management and failover handling in a containerized environment.

# Command for Floating IP Configuration
The floating IP configuration is handled in the setup_cluster.sh script for the initial node. The relevant command in the script is:
 `$ pcs resource create FloatingIP ocf:heartbeat:IPaddr2 ip=172.20.0.5 cidr_netmask=32 nic=eth0 op monitor interval=30s`
1. Creates a floating IP resource: The resource is named FloatingIP.
2. Resource type: The resource type is ocf:heartbeat:IPaddr2.
3. IP Address: The floating IP address is set to 172.20.0.5.
4. CIDR Netmask: The netmask is set to 32, indicating a single IP address.
5. Network Interface: The floating IP will be bound to the eth0 network interface.
6. Monitoring: The resource is monitored every 30 seconds to ensure it is running correctly.
# Explanation of Floating IP Transfer
In the setup the pcs resource create FloatingIP command ensures that the floating IP address 172.20.0.5 is monitored and managed by Pacemaker. If the node currently hosting the floating IP goes down, Pacemaker will automatically transfer the floating IP to another node in the cluster. This is made possible by the high availability configuration and the monitoring interval specified (30 seconds).

# Installation Steps
# Clone the Project:
`$ git clone https://github.com/yourusername/pacemaker-corosync-docker.git`

Change directory to the project:
`$ cd pacemaker-corosync-docker`

# Run Docker Compose:
`$ docker-compose up --build -d`

# Access the Jenkins Container (webz-004):
`$ docker exec -it webz-004 bash`

# Install MySQL Client in Jenkins Container:
`$ apt update && apt install default-mysql-client -y`

Ensure that Jenkins is running and accessible via http://localhost:8080.

#!/bin/bash

# Set password for hacluster user
echo "hacluster:mypassword" | chpasswd

# Add hostnames to /etc/hosts
echo "172.20.0.2 webz-001" >> /etc/hosts
echo "172.20.0.3 webz-002" >> /etc/hosts
echo "172.20.0.4 webz-003" >> /etc/hosts

# Authenticate and configure the cluster
pcs cluster auth webz-001 -u hacluster -p mypassword
pcs cluster setup --name webz_cluster webz-001
pcs cluster start --all
pcs property set stonith-enabled=false
pcs property set no-quorum-policy=ignore

# Configure Floating IP and Apache resources
pcs resource create FloatingIP ocf:heartbeat:IPaddr2 ip=172.20.0.5 cidr_netmask=16 nic=eth0 op monitor interval=30s
pcs resource create Apache ocf:heartbeat:apache configfile=/etc/apache2/apache2.conf op monitor interval=30s
pcs constraint colocation add Apache with FloatingIP INFINITY
pcs constraint order FloatingIP then Apache

touch /pcs_configured


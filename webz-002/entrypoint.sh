#!/bin/bash

# Start Corosync and Pacemaker
service corosync start
service pacemaker start

# Authenticate and start cluster
if [ ! -f /pcs_configured ]; then
  echo "hacluster:mypassword" | chpasswd
  echo "172.20.0.2 webz-001" >> /etc/hosts
  echo "172.20.0.3 webz-002" >> /etc/hosts
  echo "172.20.0.4 webz-003" >> /etc/hosts

  pcs cluster auth webz-002 -u hacluster -p mypassword
  pcs cluster start --all

  touch /pcs_configured
fi

# Run MySQL setup script
/setup_mysql.sh

# Run Apache2 start script
/start_apache.sh

# Keep container running
tail -f /dev/null


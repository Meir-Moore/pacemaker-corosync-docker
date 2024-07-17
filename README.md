# Disclaimer
This project is for educational purposes only. It is intended to demonstrate the setup and configuration of a multi-node cluster using Pacemaker and Corosync in a Docker environment. Use at your own risk.


# pacemaker-corosync-docker
This repository contains a Docker-based setup for managing a multi-node cluster with Pacemaker and Corosync. The project includes configurations for Apache, MySQL, and Jenkins, showcasing automated cluster management and failover handling in a containerized environment.


## Table of Contents

- [Description](#description)
- [Installation](#installation)
- [Usage](#usage)
- [Configuration](#configuration)
  
## Description

This project aims to simplify the deployment of a high availability (HA) cluster using Pacemaker and Corosync within Docker containers. It is designed for users who need to quickly set up and test HA clusters without the overhead of configuring a full-fledged server environment.

## Installation

### Prerequisites

- Docker installed on your machine
- Docker Compose (optional but recommended)

### Steps

1. Clone the repository:
    ```bash
    git git clone https://github.com/yourusername/pacemaker-corosync-docker.git
    cd pacemaker-corosync-docker
    ```

2. Build and run the Docker images:
    ```bash
    docker-compose up --build -d
    ```

3. Access Jenkins Container:
An sql client must be installed on jenkins machine for the purpose of output the floating ip response of the active machine
    ```bash
    docker exec -it webz-004 bash
    apt update && apt install default-mysql-client -y
    ```

## Usage

Once the containers are up and running, you can interact with the Pacemaker and Corosync services inside the Docker containers.

### Testing Data in the Database
To verify that the Jenkins job is saving the output to the active node's database, you can check the data in the mytable table on each of the containers:
1. Check data on webz-001:
   ```bash
   docker exec -it webz-001 mysql -u root -pmypassword -e "USE webziodb; SELECT * FROM mytable;"```
2. Check data on webz-002:
   ```bash
   docker exec -it webz-002 mysql -u root -pmypassword -e "USE webziodb; SELECT * FROM mytable;"```
3. Check data on webz-003:
   ```bash
   docker exec -it webz-003 mysql -u root -pmypassword -e "USE webziodb; SELECT * FROM mytable;"```

### Testing the Floating IP Failover
To verify that the floating IP is transferred to another node when the active node goes down, follow these steps:
1. Identify the active node by running the Jenkins job. The job will log the active node's IP.
2. Stop the active container (replace <container_name> with the actual container name):
`$ docker stop <container_name>`

3. Run the Jenkins job again to ensure that the floating IP has been transferred to another node. The log should show the IP of the new active node.
4. Check the data in the mytable table on each of the containers to confirm the failover (if necessary):
```bash
docker exec -it webz-001 mysql -u root -pmypassword -e "USE webziodb; SELECT * FROM mytable;"
docker exec -it webz-002 mysql -u root -pmypassword -e "USE webziodb; SELECT * FROM mytable;"
docker exec -it webz-003 mysql -u root -pmypassword -e "USE webziodb; SELECT * FROM mytable;"
```

Configuration
You can customize the cluster configuration by modifying the configuration files located in the config directory. After making changes, restart the Docker containers to apply the new configuration.

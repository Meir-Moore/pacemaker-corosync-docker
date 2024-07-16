FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get install -y apache2 pacemaker corosync pcs iproute2 iputils-ping wget curl tzdata mysql-server && \
    apt-get clean && \
    ln -fs /usr/share/zoneinfo/Asia/Jerusalem /etc/localtime && \
    dpkg-reconfigure --frontend noninteractive tzdata

COPY entrypoint.sh /entrypoint.sh
COPY corosync.conf /etc/corosync/corosync.conf
COPY setup_mysql.sh /setup_mysql.sh
COPY start_apache.sh /start_apache.sh
RUN chmod +x /entrypoint.sh /setup_mysql.sh /start_apache.sh

EXPOSE 80 3306

CMD ["/entrypoint.sh"]


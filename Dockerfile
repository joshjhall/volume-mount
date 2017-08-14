FROM ubuntu:16.04

RUN apt-get update && apt-get -y install -qq autofs cifs-utils && \
	apt-get clean && rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

# Make volumes available
VOLUME ["/mount"]

# Add autofs files
COPY auto.server /etc/
COPY auto.server.auth /etc/
COPY auto.master /etc/

# Set permissions
RUN chmod 0400 /etc/auto.server
RUN chmod 0400 /etc/auto.server.auth
RUN chmod 0400 /etc/auto.master

# Copy the init file
COPY init.sh /
RUN chmod 0755 /init.sh

# Initialize the container
CMD ["/init.sh"]

# Use phusion/baseimage as base image. To make your builds reproducible, make
# sure you lock down to a specific version, not to `latest`!
# See https://github.com/phusion/baseimage-docker/releases for
# a list of version numbers.
FROM phusion/baseimage
MAINTAINER Josh Hall, joshjhall

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# Install needed packages
RUN apt-get update && apt-get -y install -qq cifs-utils

# Clean up apt
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Copy the init file
RUN mkdir -p /etc/my_init.d
COPY init.sh /etc/my_init.d/init.sh
RUN chmod +x /etc/my_init.d/init.sh

# Make volumes available
VOLUME ["/mount"]

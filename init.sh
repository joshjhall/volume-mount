#!/bin/bash

# Mount the directory
exec mount -t cifs //$SERVER/$DIR /mount -o username=$USERNAME,password=$PASSWORD,iocharset=utf8,file_mode=0777,dir_mode=0777,soft,user,noperm,uid=${UID:-1000},gid=${GID:-1000}

# TODO: Setup something that will periodically check the connection and restart the connection (or close the container to be restarted automatically) if necessary

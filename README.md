# Introduction
This is a simple docker container to mount a CIFS share and expose it to other docker containers.  This leverages autofs, so should automatically reconnect if the network is dropped or server restarts.

*IMPORTANT:* The mounts assume read-write.  I apply permissions on the server side, so it doesn't matter much on this container.  If you need to constrain permissions in the client, or don't use a username/password, then this solution probably won't work for you.

# Environment variables

`DIR` = The mount directory (e.g., `\\server\<MOUNT DIRECTORY>`)

`SERVER` = The server being mounted (e.g., `\\<SERVER>\mounted_directory`)

`UID` = UID for the mounted files (defaults to 1000)

`GID` = GID for the mounted files (defaults to 1000)

`USERNAME` = Username for the SMB server

`PASSWORD` = Password for the SMB server


# How to use
The resulting mount will be exposed as a volume in `/mount/<DIR>/`.  This allows multiple containers to manage several connections to the same server for different directories.  All of these can then be used by another container.

For example...

Creating a connection to `\\myserver\mydir`

`docker run --name mount -e "SERVER=myserver" -e "DIR=mydir" -e "USERNAME=rose" -e "PASSWORD=tyler" --cap-add SYS_ADMIN --cap-add DAC_READ_SEARCH mount`

*IMPORTANT:* You need to include `--cap-add SYS_ADMIN --cap-add DAC_READ_SEARCH` for the mount to work.  `--privileged` will also do the trick, but you don't need to grant that many permissions to the container.

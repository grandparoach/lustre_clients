#!/bin/bash

MASTER_NAME=$1
echo $MASTER_NAME

# disable selinux
    sed -i 's/enforcing/disabled/g' /etc/selinux/config
    setenforce permissive

# Shares
SHARE_HOME=/share/home

mkdir -p /share
mkdir -p $SHARE_HOME

# User
HPC_USER=hpcuser
HPC_UID=7007
HPC_GROUP=hpc
HPC_GID=7007

yum -y install nfs-utils nfs-utils-lib


echo "$MASTER_NAME:$SHARE_HOME $SHARE_HOME    nfs4    rw,auto,_netdev 0 0" >> /etc/fstab
mount -a
mount
   
groupadd -g $HPC_GID $HPC_GROUP

# Don't require password for HPC user sudo
echo "$HPC_USER ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
    
# Disable tty requirement for sudo
sed -i 's/^Defaults[ ]*requiretty/# Defaults requiretty/g' /etc/sudoers

useradd -c "HPC User" -g $HPC_GROUP -d $SHARE_HOME/$HPC_USER -s /bin/bash -u $HPC_UID $HPC_USER

chown $HPC_USER:$HPC_GROUP $SHARE_DATA	

exit 0

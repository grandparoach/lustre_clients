#!/bin/bash

MASTER_HOSTNAME=$1

USER=$2
yum install -y -q nfs-utils
mkdir -p /mnt/nfsshare
mkdir -p /mnt/resource/scratch
chmod 777 /mnt/nfsshare
systemctl enable rpcbind
systemctl enable nfs-server
systemctl enable nfs-lock
systemctl enable nfs-idmap
systemctl start rpcbind
systemctl start nfs-server
systemctl start nfs-lock
systemctl start nfs-idmap
localip=`hostname -i | cut --delimiter='.' -f -3`
echo "$MASTER_HOSTNAME:/mnt/nfsshare    /mnt/nfsshare   nfs defaults 0 0" | tee -a /etc/fstab
echo "$MASTER_HOSTNAME:/mnt/resource/scratch    /mnt/resource/scratch   nfs defaults 0 0" | tee -a /etc/fstab

mount -a

# Don't require password for HPC user sudo
echo "$USER ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
    
# Disable tty requirement for sudo
sed -i 's/^Defaults[ ]*requiretty/# Defaults requiretty/g' /etc/sudoers

ln -s /opt/intel/impi/5.1.3.181/intel64/bin/ /opt/intel/impi/5.1.3.181/bin
ln -s /opt/intel/impi/5.1.3.181/lib64/ /opt/intel/impi/5.1.3.181/lib
chown -R $USER:$USER /mnt/resource/

df




# Sets all common environment variables and system parameters.
#

    # Intel MPI config for IB
    echo "# IB Config for MPI" > /etc/profile.d/hpc.sh
    echo "export I_MPI_FABRICS=shm:dapl" >> /etc/profile.d/hpc.sh
    echo "export I_MPI_DAPL_PROVIDER=ofa-v2-ib0" >> /etc/profile.d/hpc.sh
    echo "export I_MPI_DYNAMIC_CONNECTION=0" >> /etc/profile.d/hpc.sh



# lustre_clients

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fgrandparoach%2Flustre_clients%2Fdiscrete%2Fazuredeploy.json" target="_blank">
    <img src="http://azuredeploy.net/deploybutton.png"/>
</a>
<a href="http://armviz.io/#/?load=https%3A%2F%2Fraw.githubusercontent.com%2Fgrandparoach%2Fmaster%2Flustre_clients%2Fazuredeploy.json" target="_blank">
    <img src="http://armviz.io/visualizebutton.png"/>
</a>


Templates and scripts for deploying a Node which serves as an NFS Server and a JumpBox to the Compute Nodes. The Compute Nodes will also be comfigured as Lustre Clients. The compute nodes will be deployed to to a VM Scale Set. All the machines are built using Managed Storage.

The Jump Box and the Compute nodes will be provisioned onto an existing Virtual Network - the one that was built when the Lustre Servers  were provisioned.  The Jump Box will have a public IP Address, but the Compute nodes will not.

The images to be deployed on the Master and the Compute nodes can be selected from input parameters.  

Besides the admin user, it also provisions a user account on all of the machines named "hpcuser".  This user will have its home directory provisioned on the NFS server so that the .ssh directory will be shared among all the nodes enabling ssh connections between all of them.

Consequently, all MPI jobs must be run as the "hpcuser" - (sudo su hpcuser).

For MPI jobs, be sure to select the H16r, or H16mr VMsku and the CentOS-HPC-7.1 image.  This will have the Infiniband drivers and the Intel MPI included in the image.

Make sure that the Environment variables are set according to the example at this site https://docs.microsoft.com/en-us/azure/virtual-machines/linux/classic/rdma-cluster as specified in the "Configure Intel MPI" section.


Based on the templates by Arsen Vladimirskiy from this repository:
https://github.com/Azure/azure-quickstart-templates/tree/master/intel-lustre-clients-on-centos 



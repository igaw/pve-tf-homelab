# Terraform-Ansible template for setting up a homelab

This project is a template to setup a Proxmox based homelab using Terraform and Ansible. This avoids the usual problems when doing this manually.

## Proxmox: install and configuration

- Install Proxmox with default setting on a new node
- Create a host file containing the node configuration in ansible-pve/hosts_vars
- Apply changes to node by running the ansible-pve playbook (see ansible-pve/run.sh)
  The main changes in this step is to setup the VM and CT templates
 
## Terraform: deploy new VMs

- Configure the VMs in `tf/ct/var.tf`
- Apply changes with: 
  ```shell
  $ cd tf/ct
  $ terraform init
  $ terraform apply
  ```

provider "proxmox" {
  pm_api_url            = var.proxmox_host["pm_api_url"]
  pm_api_token_id       = var.proxmox_host["pm_api_token_id"]
  pm_api_token_secret   = var.proxmox_host["pm_api_token_secret"]
  pm_tls_insecure       = true
}

resource "proxmox_vm_qemu" "vm" {
  count                 = length(var.hostnames)
  name                  = var.hostnames[count.index]
  target_node           = var.proxmox_host["target_node"]
  vmid                  = var.vmid + count.index
  full_clone            = true
  clone                 = var.clone[count.index]

  sockets               = 1
  cores                 = 2
  vcpus                 = 2
  memory                = 2048
  balloon               = 2048
  boot                  = "c"
  bios                  = "ovmf"
  machine               = "q35"

  bootdisk              = "virtio0"

  scsihw                = "virtio-scsi-pci"

  onboot                = false
  agent                 =  1
  cpu                   = "kvm64"
  numa                  = true
  hotplug               = "network,disk,cpu,memory"
  
  network {
    bridge              = "vmbr0"
    model               = "virtio"
  }
  
  ipconfig0             = "ip=${var.ips[count.index]}/24,gw=${cidrhost(format("%s/24", var.ips[count.index]), 1)}"
  nameserver            = "${var.nameserver}"
  searchdomain          = "${var.searchdomain}"
  
  disk {
    type                = "virtio"
    storage             = "local-lvm"
    size                = var.rootfs_size[count.index]
  }

  ssh_user              = var.user[count.index]
  sshkeys               = file(var.ssh_keys["pub"])

  os_type               = "cloud-init"

  connection {
    host                = var.ips[count.index]
    user                = var.user[count.index]
    private_key         = file(var.ssh_keys["priv"])
    agent               = false
    timeout             = "3m"
  }

  provisioner "remote-exec" {
    inline              = [ "echo 'ready for provisioning'"]
  }
  
  provisioner "local-exec" {
    working_dir         = "../../ansible/"
    command             = "ansible-playbook -u ${var.user[count.index]} --key-file ${var.ssh_keys["priv"]} -i ${var.ips[count.index]}, provision.yaml"
  }
}

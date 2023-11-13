variable "proxmox_host" {
  type = map
  default = {
    pm_api_url            = "https://lithium.lan:8006/api2/json"
    pm_api_token_id       = "root@pam!terraform"
    pm_api_token_secret   = "a1b760e9-1258-4d71-9119-e7b462419d89"
    target_node           = "lithium"
  }
}

variable "vmid" {
  description             = "Starting ID for the CTs"
  default                 = 500
}

variable "hostnames" {
  type                    = list(string)
  description             = "VMs to be created"
  default                 = [ "tw0", "fed0", "ub0", "deb0" ]
}

variable "rootfs_size" {
  type                    = list(string)
  default                 = [ "5G", "5G", "5G", "5G" ]
}

variable "ips" {
  type                    = list(string)
  description             = "IPs of the VMs, respective to the hostname order"
  default                 = [ "192.168.154.30", "192.168.154.31", "192.168.154.32", "192.168.154.33" ]
}

variable "nameserver" {
  default                 = "192.168.154.2"
}

variable "searchdomain" {
  default                 = "lan"
}

variable "ssh_keys" {
  type                    = map
  default = {
    pub                   = "~/.ssh/id_ed25519-tf.pub"
    priv                  = "~/.ssh/id_ed25519-tf"
  }
}

variable "clone" {
  type                    = list(string)
  default                 = [ "tumbleweed", "fedora", "ubuntu", "debian" ]
}

variable "user" {
  type                    = list(string)
  description             = "User used to SSH into the machine and provision it"
  default                 = [ "opensuse", "fedora", "ubuntu", "debian" ]
}

variable "proxmox_host" {
  type = map
  default = {
    pm_api_url = "https://lithium.lan:8006/api2/json"
#    pm_api_token_id="tf-prov@pve!terraform"
#    pm_api_token_secret = "c76234eb-b2d3-414e-80a3-8e4e43b62425"
    pm_api_token_id="root@pam!terraform"
    pm_api_token_secret = "a1b760e9-1258-4d71-9119-e7b462419d89"
    target_node = "lithium"
  }
}

variable "vmid" {
  default     = 300
  description = "Starting ID for the CTs"
}

variable "hostnames" {
  description = "Containers to be created"
  type        = list(string)
  default     = ["ct0"]
}

variable "rootfs_size" {
  description = "Root filesystem size in GB"
  default = "2G"
}

variable "ips" {
  description = "IPs of the containers, respective to the hostname order"
  type        = list(string)
  default     = ["192.168.154.23"]
}

variable "user" {
  default     = "root"
  description = "Ansible user used to provision the container"
}

variable "ssh_keys" {
  type = map
  default = {
    pub = "~/.ssh/id_ed25519-tf.pub"
    priv = "~/.ssh/id_ed25519-tf"
  }
}

variable "vm_name" {
  description = "Name of the VM"
  type        = string
}

variable "vm_count" {
  description = "Number of VMs to create"
  type        = number
  default     = 1
}

variable "vm_ip" {
  description = "Static IP with CIDR e.g. 192.168.5.44/24"
  type        = list(string)
}

variable "vm_gateway" {
  description = "Gateway IP"
  type        = string
}

variable "vm_vlan" {
  description = "VLAN ID"
  type        = number
}

variable "vm_cores" {
  description = "Number of CPU cores"
  type        = number
  default     = 2
}

variable "vm_memory" {
  description = "Memory in MB"
  type        = number
  default     = 2048
}

variable "vm_disk_size" {
  description = "Disk size in GB"
  type        = number
  default     = 24
}

variable "prox_node" {
  description = "Proxmox node name"
  type        = list(string)
  }

variable "datastore" {
  description = "Proxmox storage name"
  type        = string
  default     = "vm-ceph"
}

variable "ssh_public_key" {
  description = "SSH public key for VM access"
  type        = string
}

variable "vm_user" {
  type      = string
  sensitive = true
}

variable "vm_password" {
  type      = string
  sensitive = true
}

variable "data_disk_size" {
  type        = number
  default     = null
  description = "Size of optional data disk in GB. Omit or set null to skip."
}

variable "data_disk_datastore" {
  type        = string
  default     = null
  description = "Datastore for data disk. Defaults to main datastore if not set."
}
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
  type        = string
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
  type        = string
  default     = "toothless"
}

variable "datastore" {
  description = "Proxmox storage name"
  type        = string
  default     = "local-lvm"
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

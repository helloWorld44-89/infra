variable "proxmox_url" {
  description = "Proxmox API URL"
  type        = string
}

variable "proxmox_api_token" {
  description = "Proxmox API token"
  type        = string
  sensitive   = true
}

variable "ssh_public_key" {
  description = "SSH public key for VM access"
  type        = string
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
variable "vm_count" {
  description = "Number of VMs to create"
  type        = number
  default     = 1
}
variable "prox_node" {
  description = "Proxmox Node"
  type = string
  default = "toothless"
}
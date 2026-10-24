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

variable "vm_username" {
  type      = string
  sensitive = true
}

variable "vm_password" {
  type      = string
  sensitive = true
}

variable "vm_ip" {
  description = "Static IP with CIDR e.g. 192.168.5.46/24"
  type        = string
  default     = "192.168.5.44/24"
}

variable "vm_gateway" {
  description = "Gateway IP"
  type        = string
  default     = "192.168.5.1"
}

variable "vm_vlan" {
  description = "VLAN ID (omit/null for untagged -- the main LAN on vmbr0 is untagged)"
  type        = number
  default     = null
  nullable    = true
}

variable "vm_count" {
  description = "Number of VMs to create"
  type        = number
  default     = 1
}

variable "prox_node" {
  description = "Proxmox Node"
  type        = string
  default     = "Smaug"
}

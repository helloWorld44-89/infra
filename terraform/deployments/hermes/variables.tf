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
  description = "Static IP with CIDR for prod-openclaw-01"
  type        = list(string)
  default     = ["192.168.5.50/24"]
}

variable "vm_gateway" {
  description = "Gateway IP"
  type        = string
  default     = "192.168.5.1"
}

variable "vm_vlan" {
  description = "VLAN ID"
  type        = number
}

variable "prox_node" {
  description = "Proxmox node(s) to deploy on"
  type        = list(string)
  default     = ["Balerion"]
}

variable "vm_user" {
  description = "VM login username"
  type        = string
  sensitive   = true
}

variable "vm_password" {
  description = "VM login password"
  type        = string
  sensitive   = true
}

variable "data_disk_size" {
  description = "Size of the OpenClaw data disk in GB (mounted at /opt/openclaw)"
  type        = number
  default     = 100
}

output "vm_name" {
  description = "Name of the created VM"
  value       = proxmox_virtual_environment_vm.vm[*].name
}

output "vm_ip" {
  description = "IP address of the VM"
  value       = var.vm_ip
}

output "vm_id" {
  description = "Proxmox VM ID"
  value       = proxmox_virtual_environment_vm.vm[*].vm_id
}
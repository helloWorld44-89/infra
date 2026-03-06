module "keyshift_vm" {
  source         = "../../modules/dockerDev-vm"
  vm_name        = "keyshift"
  vm_ip          = var.vm_ip
  vm_gateway     = var.vm_gateway
  vm_vlan        = var.vm_vlan
  ssh_public_key = var.ssh_public_key
  vm_count       = var.vm_count
  vm_cores     = 2
  vm_memory    = 2048
  vm_disk_size = 24
}

output "keyshift_ip" {
  value = module.keyshift_vm.vm_ip
}
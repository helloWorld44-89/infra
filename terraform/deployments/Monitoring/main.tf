module "dockerDebian" {
  source         = "../../modules/monitoringServer"
  vm_name        = "prod-debsrv"
  vm_ip          = var.vm_ip
  vm_gateway     = var.vm_gateway
  vm_vlan        = var.vm_vlan
  ssh_public_key = var.ssh_public_key
  vm_count       = var.vm_count
  vm_cores     = 4
  vm_memory    = 4096
  vm_disk_size = 35
  prox_node = "Balerion"
  vm_password = var.vm_password
  vm_user     = var.vm_user
}

output "vm_ip" {
  value = module.dockerDebian.vm_ip
}
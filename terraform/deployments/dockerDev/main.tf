module "dockerDev_vm" {
  source         = "../../modules/dockerDev-vm"
  vm_name        = "dev-ubsrv"
  vm_ip          = var.vm_ip
  vm_gateway     = var.vm_gateway
  vm_vlan        = var.vm_vlan
  ssh_public_key = var.ssh_public_key
  vm_count       = var.vm_count
  vm_cores     = 4
  vm_memory    = 4096
  vm_disk_size = 20
}

output "vm_ip" {
  value = module.dockerDev_vm.vm_ip
}
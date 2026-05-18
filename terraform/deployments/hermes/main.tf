module "ubuntuVM" {
  source         = "../../modules/ubuntuVM"
  vm_name        = "prod-hermes-01"
  vm_ip          = var.vm_ip
  vm_gateway     = var.vm_gateway
  vm_vlan        = var.vm_vlan
  ssh_public_key = var.ssh_public_key
  prox_node      = var.prox_node
  vm_count       = 1
  vm_cores       = 4
  vm_memory      = 8192
  vm_disk_size   = 50
  datastore      = "vm-ceph"
  vm_user        = var.vm_user
  vm_password    = var.vm_password
  data_disk_size = var.data_disk_size
}

output "hermes_ip" {
  value = module.ubuntuVM.vm_ip
}

output "hermes_id" {
  value = module.ubuntuVM.vm_id
}

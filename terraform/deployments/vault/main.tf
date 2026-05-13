module "ubuntuVM" {
  source         = "../../modules/ubuntuVM"
  vm_name        = "prod-vaultSrv"
  vm_ip          = var.vm_ip
  vm_gateway     = var.vm_gateway
  vm_vlan        = var.vm_vlan
  ssh_public_key = var.ssh_public_key
  vm_count       = var.vm_count
  vm_cores     = 2
  vm_memory    = 4096
  vm_disk_size = 40
<<<<<<< HEAD
  vm_password = "Baseball44"
  vm_user = "jconder44"
=======
  vm_password = "REDACTED"
  vm_user = "REDACTED"
>>>>>>> 5d5e7005fd885c4476c0b2b92cfa756e26074087
  data_disk_size = var.data_disk_size
  data_disk_datastore = "local-lvm"
}

output "ubuntuVM_ip" {
  value = module.ubuntuVM.vm_ip
}
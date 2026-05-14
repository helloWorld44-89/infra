module "k3sWorkers" {
  source         = "../../modules/ubuntuVM"
  vm_name        = "prod-k3s"
  vm_ip          = var.vm_ip
  vm_gateway     = var.vm_gateway
  vm_vlan        = var.vm_vlan
  ssh_public_key = var.ssh_public_key
  vm_count       = var.vm_count
  vm_cores     = 4
  vm_memory    = 8192
  vm_disk_size = 50
  prox_node = ["Balerion","Smaug","toothless"]
  vm_user = var.vm_user
  vm_password = var.vm_password
}
module "k3sMaster" {
  source         = "../../modules/ubuntuVM"
  vm_name        = "prod-k3s-master"
  vm_ip          = ["192.168.5.65/24"]
  vm_gateway     = var.vm_gateway
  vm_vlan        = var.vm_vlan
  ssh_public_key = var.ssh_public_key
  vm_count       = 1
  vm_cores     = 2
  vm_memory    = 4096
  vm_disk_size = 32
  prox_node = ["Balerion","Smaug","toothless"]
  vm_user = var.vm_user
  vm_password = var.vm_password
}

output "worker_ip" {
  value = module.k3sWorkers.vm_ip
}
output master_ip {
  value = module.k3sMaster.vm_ip
} 
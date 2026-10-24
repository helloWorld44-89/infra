module "codingVM" {
  source         = "../../modules/dockerDev-vm"
  vm_name        = "codebox"
  vm_ip          = var.vm_ip
  vm_gateway     = var.vm_gateway
  vm_vlan        = var.vm_vlan
  ssh_public_key = var.ssh_public_key
  vm_user        = var.vm_user
  vm_password    = var.vm_password
  vm_count       = var.vm_count
  prox_node      = var.prox_node

  # Ubuntu 24.04 LTS, Docker for local testing, lightweight since
  # Claude Code itself is just an API orchestrator -- not a build box.
  vm_cores     = 4
  vm_memory    = 8192  # 8GB
  vm_disk_size = 60    # Docker image layers add up
  # datastore defaults to "local-lvm" in the module -- intentional,
  # keeps this off the Ceph OSD disk shared by Balerion.
}

output "vm_ip" {
  value = module.codingVM.vm_ip
}

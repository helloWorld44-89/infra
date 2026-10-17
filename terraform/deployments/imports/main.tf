/// This file is used to import existing Proxmox VMs into Terraform state. Each import block specifies the target resource and the ID of the existing VM in Proxmox.

// VMs on Proxmox Cluster
import {
  to = proxmox_virtual_environment_vm.prod-ubsrv-1
  id = "toothless/117"
}
import {
  to = proxmox_virtual_environment_vm.prod-ubsrv-2
  id = "Balerion/115"
}
import {
  to = proxmox_virtual_environment_vm.prod-ubsrv-3
  id = "toothless/114"
}
import {
  to = proxmox_virtual_environment_vm.prod-debsrv
  id = "Balerion/105"
}
import {
  to = proxmox_virtual_environment_vm.fedsr02
  id = "Balerion/108"
}
import {
  to = proxmox_virtual_environment_vm.haos14
  id = "Balerion/107"
}
// NOTE 2026-10-05: these 4 were on Smaug until an interrupted `terraform apply`
// triggered a shutdown (reboot_after_update=true) and Proxmox HA failed them
// over to Balerion on restart. node_name below updated to match; see homelab
// skill incident note before attempting to move them back to Smaug.
import {
  to = proxmox_virtual_environment_vm.dev-ubsrv
  id = "toothless/116"
}
// prod-vaultSrv removed 2026-10-05: Vault was destroyed; vmid toothless/100
// was reused for prod-k3s-3 (imported below under its new identity).
// addyWin01 removed 2026-10-05: no longer exists on Proxmox (toothless/113 gone).

//Containers
import {
  to = proxmox_virtual_environment_container.pisrv01
  id = "toothless/103"
}
import {
  to = proxmox_virtual_environment_container.pisrv02
  id = "toothless/112"
}
import {
  to = proxmox_virtual_environment_container.myspeed
  id = "toothless/109"
}
import {
  to = proxmox_virtual_environment_container.omada
  id = "toothless/110"
}

// Added 2026-10-05: previously untracked k3s + agents VMs
import {
  to = proxmox_virtual_environment_vm.prod-k3s-1
  id = "Balerion/102"
}
import {
  to = proxmox_virtual_environment_vm.prod-k3s-2
  id = "Smaug/101"
}
import {
  to = proxmox_virtual_environment_vm.prod-k3s-3
  id = "toothless/100"
}
import {
  to = proxmox_virtual_environment_vm.prod-k3s-master
  id = "toothless/104"
}
import {
  to = proxmox_virtual_environment_vm.prod-agents-01
  id = "Balerion/106"
}
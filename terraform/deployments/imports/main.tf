/// This file is used to import existing Proxmox VMs into Terraform state. Each import block specifies the target resource and the ID of the existing VM in Proxmox.

// VMs on Proxmox Cluster
import {
  to = proxmox_virtual_environment_vm.prod-ubsrv-1
  id = "Balerion/117"
}
import {
  to = proxmox_virtual_environment_vm.prod-ubsrv-2
  id = "Smaug/115"
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
  id = "Smaug/108"
}
import {
  to = proxmox_virtual_environment_vm.haos14
  id = "Smaug/107"
}
import {
  to = proxmox_virtual_environment_vm.dev-ubsrv
  id = "toothless/116"
}
import {
  to = proxmox_virtual_environment_vm.prod-vaultSrv
  id = "toothless/100"
}
import {
    to = proxmox_virtual_environment_vm.addyWin01
    id = "toothless/113"
}
//Containers
import {
  to = proxmox_virtual_environment_container.pisrv01
  id = "toothless/103"
}
import {
  to = proxmox_virtual_environment_container.pisrv02
  id = "Smaug/112"
}
import {
  to = proxmox_virtual_environment_container.myspeed
  id = "toothless/109"
}
import {
  to = proxmox_virtual_environment_container.omada
  id = "toothless/110"

}
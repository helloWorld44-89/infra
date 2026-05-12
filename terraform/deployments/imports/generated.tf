# __generated__ by Terraform
# Please review these resources and move them into your main configuration files.

# __generated__ by Terraform from "toothless/103"
resource "proxmox_virtual_environment_container" "pisrv01" {
  description           = "preclone\n"
  environment_variables = {}
  hook_script_file_id   = null
  node_name             = "toothless"
  pool_id               = null
  protection            = false
  start_on_boot         = null
  started               = true
  tags                  = ["proxmox-helper-scripts"]
  template              = false
  timeout_clone         = null
  timeout_create        = null
  timeout_delete        = null
  timeout_update        = null
  unprivileged          = false
  console {
    enabled   = true
    tty_count = 2
    type      = "tty"
  }
  disk {
    acl           = false
    datastore_id  = "vm-ceph"
    mount_options = []
    quota         = false
    replicate     = false
    size          = 2
  }
  initialization {
    entrypoint = null
    hostname   = "pisrv01"
    ip_config {
      ipv4 {
        address = "192.168.4.13/24"
        gateway = "192.168.4.1"
      }
    }
    ip_config {
      ipv4 {
        address = "192.168.3.5/26"
        gateway = "192.168.3.1"
      }
    }
    ip_config {
      ipv4 {
        address = "192.168.10.5/24"
        gateway = "192.168.10.1"
      }
    }
    ip_config {
      ipv4 {
        address = "192.168.5.5/24"
        gateway = "192.168.5.1"
      }
    }
  }
  memory {
    dedicated = 512
    swap      = 512
  }
  network_interface {
    bridge      = "vmbr0"
    firewall    = false
    mac_address = "BC:24:11:FA:01:44"
    mtu         = 0
    name        = "eth0"
    rate_limit  = 0
    vlan_id     = 4
  }
  network_interface {
    bridge      = "vmbr0"
    firewall    = false
    mac_address = "BC:24:11:83:C6:EF"
    mtu         = 0
    name        = "net3"
    rate_limit  = 0
    vlan_id     = 3
  }
  network_interface {
    bridge      = "vmbr0"
    firewall    = false
    mac_address = "BC:24:11:FA:F1:2F"
    mtu         = 0
    name        = "net10"
    rate_limit  = 0
    vlan_id     = 10
  }
  network_interface {
    bridge      = "vmbr0"
    firewall    = false
    mac_address = "BC:24:11:7E:E1:2B"
    mtu         = 0
    name        = "net5"
    rate_limit  = 0
    vlan_id     = 0
  }
  operating_system {
    template_file_id = ""
    type             = "debian"
  }
}

# __generated__ by Terraform from "Smaug/112"
resource "proxmox_virtual_environment_container" "pisrv02" {
  description           = "Pihole LXC\n"
  environment_variables = {}
  hook_script_file_id   = null
  node_name             = "Smaug"
  pool_id               = null
  protection            = false
  start_on_boot         = null
  started               = true
  tags                  = ["proxmox-helper-scripts"]
  template              = false
  timeout_clone         = null
  timeout_create        = null
  timeout_delete        = null
  timeout_update        = null
  unprivileged          = false
  console {
    enabled   = true
    tty_count = 2
    type      = "tty"
  }
  disk {
    acl           = false
    datastore_id  = "vm-ceph"
    mount_options = []
    quota         = false
    replicate     = false
    size          = 2
  }
  initialization {
    entrypoint = null
    hostname   = "pisrv02"
    ip_config {
      ipv4 {
        address = "192.168.4.14/24"
        gateway = "192.168.4.1"
      }
    }
    ip_config {
      ipv4 {
        address = "192.168.3.6/26"
        gateway = "192.168.3.1"
      }
    }
    ip_config {
      ipv4 {
        address = "192.168.10.6/24"
        gateway = "192.168.10.1"
      }
    }
    ip_config {
      ipv4 {
        address = "192.168.5.6/24"
        gateway = "192.168.5.1"
      }
    }
  }
  memory {
    dedicated = 512
    swap      = 512
  }
  network_interface {
    bridge      = "vmbr0"
    firewall    = false
    mac_address = "BC:24:11:79:94:8E"
    mtu         = 0
    name        = "eth0"
    rate_limit  = 0
    vlan_id     = 4
  }
  network_interface {
    bridge      = "vmbr0"
    firewall    = false
    mac_address = "BC:24:11:87:48:26"
    mtu         = 0
    name        = "net3"
    rate_limit  = 0
    vlan_id     = 3
  }
  network_interface {
    bridge      = "vmbr0"
    firewall    = false
    mac_address = "BC:24:11:4E:BF:19"
    mtu         = 0
    name        = "net10"
    rate_limit  = 0
    vlan_id     = 10
  }
  network_interface {
    bridge      = "vmbr0"
    firewall    = false
    mac_address = "BC:24:11:2F:2D:99"
    mtu         = 0
    name        = "net5"
    rate_limit  = 0
    vlan_id     = 0
  }
  operating_system {
    template_file_id = ""
    type             = "debian"
  }
}

# __generated__ by Terraform from "toothless/109"
resource "proxmox_virtual_environment_container" "myspeed" {
  description           = "MySpeed LXC\n"
  environment_variables = {}
  hook_script_file_id   = null
  node_name             = "toothless"
  pool_id               = null
  protection            = false
  start_on_boot         = null
  started               = true
  tags                  = ["community-script", "tracking"]
  template              = false
  timeout_clone         = null
  timeout_create        = null
  timeout_delete        = null
  timeout_update        = null
  unprivileged          = true
  console {
    enabled   = true
    tty_count = 2
    type      = "tty"
  }
  disk {
    acl           = false
    datastore_id  = "local-lvm"
    mount_options = []
    quota         = false
    replicate     = false
    size          = 4
  }
  initialization {
    entrypoint = null
    hostname   = "myspeed"
    ip_config {
      ipv4 {
        address = "192.168.5.120/24"
        gateway = "192.168.5.1"
      }
    }
  }
  memory {
    dedicated = 1024
    swap      = 512
  }
  network_interface {
    bridge      = "vmbr0"
    firewall    = false
    mac_address = "BC:24:11:94:B6:90"
    mtu         = 0
    name        = "eth0"
    rate_limit  = 0
    vlan_id     = 0
  }
  operating_system {
    template_file_id = ""
    type             = "debian"
  }
}

# __generated__ by Terraform from "toothless/110"
resource "proxmox_virtual_environment_container" "omada" {
  description           = "USB passthrough\n"
  environment_variables = {}
  hook_script_file_id   = null
  node_name             = "toothless"
  pool_id               = null
  protection            = false
  start_on_boot         = null
  started               = true
  tags                  = ["community-script", "controller", "tp-link"]
  template              = false
  timeout_clone         = null
  timeout_create        = null
  timeout_delete        = null
  timeout_update        = null
  unprivileged          = false
  console {
    enabled   = true
    tty_count = 2
    type      = "tty"
  }
  cpu {
    architecture = "amd64"
    cores        = 2
    units        = 1024
  }
  disk {
    acl           = false
    datastore_id  = "local-lvm"
    mount_options = []
    quota         = false
    replicate     = false
    size          = 8
  }
  initialization {
    entrypoint = null
    hostname   = "omada"
    ip_config {
      ipv4 {
        address = "192.168.5.233/24"
        gateway = "192.168.5.1"
      }
    }
  }
  memory {
    dedicated = 2048
    swap      = 512
  }
  network_interface {
    bridge      = "vmbr0"
    firewall    = false
    mac_address = "BC:24:11:8E:C5:1F"
    mtu         = 0
    name        = "eth0"
    rate_limit  = 0
    vlan_id     = 0
  }
  operating_system {
    template_file_id = ""
    type             = "debian"
  }
}

# __generated__ by Terraform
resource "proxmox_virtual_environment_vm" "prod-vaultSrv" {
  acpi                                 = true
  bios                                 = "seabios"
  boot_order                           = ["virtio0", "net0"]
  delete_unreferenced_disks_on_destroy = true
  description                          = null
  hook_script_file_id                  = null
  keyboard_layout                      = "en-us"
  kvm_arguments                        = null
  mac_addresses                        = ["00:00:00:00:00:00", "BC:24:11:1B:61:41"]
  machine                              = null
  migrate                              = false
  name                                 = "prod-vaultSrv"
  network_device = [{
    bridge       = "vmbr0"
    disconnected = false
    enabled      = true
    firewall     = false
    mac_address  = "BC:24:11:1B:61:41"
    model        = "virtio"
    mtu          = 0
    queues       = 0
    rate_limit   = 0
    trunks       = ""
    vlan_id      = 0
  }]
  node_name           = "toothless"
  on_boot             = true
  pool_id             = null
  protection          = false
  purge_on_destroy    = true
  reboot              = false
  reboot_after_update = true
  scsi_hardware       = "virtio-scsi-pci"
  started             = true
  stop_on_destroy     = false
  tablet_device       = true
  tags                = []
  template            = false
  timeout_clone       = 1800
  timeout_create      = 1800
  timeout_migrate     = 1800
  timeout_reboot      = 1800
  timeout_shutdown_vm = 1800
  timeout_start_vm    = 1800
  timeout_stop_vm     = 300
  vm_id               = 100
  agent {
    enabled = true
    timeout = "15m"
    trim    = false
    type    = "virtio"
  }
  cpu {
    affinity     = null
    architecture = null
    cores        = 2
    flags        = []
    hotplugged   = 0
    limit        = 0
    numa         = false
    sockets      = 1
    type         = "x86-64-v2-AES"
    units        = 1024 # fixed: was 0
  }
  disk {
    aio               = "io_uring"
    backup            = true
    cache             = "none"
    datastore_id      = "local-lvm"
    discard           = "on"
    file_format       = "raw"
    file_id           = null
    import_from       = null
    interface         = "virtio0"
    iothread          = true
    path_in_datastore = "vm-100-disk-0"
    replicate         = true
    serial            = null
    size              = 40
    ssd               = false
  }
  disk {
    aio               = "io_uring"
    backup            = true
    cache             = "none"
    datastore_id      = "local-lvm"
    discard           = "on"
    file_format       = "raw"
    file_id           = null
    import_from       = null
    interface         = "virtio1"
    iothread          = true
    path_in_datastore = "vm-100-disk-1"
    replicate         = true
    serial            = null
    size              = 20
    ssd               = false
  }
  initialization {
    datastore_id = "local-lvm"
    interface    = "ide2"
    dns {
      domain  = null
      servers = ["192.168.5.5", "192.168.5.6"]
    }
    ip_config {
      ipv4 {
        address = "192.168.5.35/24"
        gateway = "192.168.5.1"
      }
    }
    user_account {
      keys     = [var.ssh_public_key]
      password = var.vm_password
      username = var.vm_username
    }
  }
  memory {
    dedicated      = 4096
    floating       = 0
    hugepages      = null
    keep_hugepages = false
    shared         = 0
  }
}

# __generated__ by Terraform
resource "proxmox_virtual_environment_vm" "prod-ubsrv-1" {
  acpi                                 = true
  bios                                 = "seabios"
  boot_order                           = ["virtio0", "net0"]
  delete_unreferenced_disks_on_destroy = true
  description                          = null
  hook_script_file_id                  = null
  keyboard_layout                      = "en-us"
  kvm_arguments                        = null
  mac_addresses                        = ["00:00:00:00:00:00", "BC:24:11:13:2B:96"]
  machine                              = null
  migrate                              = false
  name                                 = "prod-ubsrv-1"
  network_device = [{
    bridge       = "vmbr0"
    disconnected = false
    enabled      = true
    firewall     = false
    mac_address  = "BC:24:11:13:2B:96"
    model        = "virtio"
    mtu          = 0
    queues       = 0
    rate_limit   = 0
    trunks       = ""
    vlan_id      = 0
  }]
  node_name           = "Balerion"
  on_boot             = true
  pool_id             = null
  protection          = false
  purge_on_destroy    = true
  reboot              = false
  reboot_after_update = true
  scsi_hardware       = "virtio-scsi-pci"
  started             = true
  stop_on_destroy     = false
  tablet_device       = true
  tags                = []
  template            = false
  timeout_clone       = 1800
  timeout_create      = 1800
  timeout_migrate     = 1800
  timeout_reboot      = 1800
  timeout_shutdown_vm = 1800
  timeout_start_vm    = 1800
  timeout_stop_vm     = 300
  vm_id               = 117
  agent {
    enabled = true
    timeout = "15m"
    trim    = false
    type    = "virtio"
  }
  cpu {
    affinity     = null
    architecture = null
    cores        = 4
    flags        = []
    hotplugged   = 0
    limit        = 0
    numa         = false
    sockets      = 1
    type         = "x86-64-v2-AES"
    units        = 1024 # fixed: was 0
  }
  disk {
    aio               = "io_uring"
    backup            = true
    cache             = "none"
    datastore_id      = "vm-ceph"
    discard           = "on"
    file_format       = "raw"
    file_id           = null
    import_from       = null
    interface         = "virtio0"
    iothread          = true
    path_in_datastore = "vm-117-disk-0"
    replicate         = true
    serial            = null
    size              = 40
    ssd               = false
  }
  initialization {
    datastore_id = "vm-ceph"
    interface    = "ide2"
    dns {
      domain  = null
      servers = ["192.168.5.5", "192.168.5.6"]
    }
    ip_config {
      ipv4 {
        address = "192.168.5.40/24"
        gateway = "192.168.5.1"
      }
    }
    user_account {
      keys     = [var.ssh_public_key]
      password = var.vm_password
      username = var.vm_username
    }
  }
  memory {
    dedicated      = 8192
    floating       = 0
    hugepages      = null
    keep_hugepages = false
    shared         = 0
  }
}

# __generated__ by Terraform
resource "proxmox_virtual_environment_vm" "prod-ubsrv-2" {
  acpi                                 = true
  bios                                 = "seabios"
  boot_order                           = ["virtio0", "net0"]
  delete_unreferenced_disks_on_destroy = true
  description                          = null
  hook_script_file_id                  = null
  keyboard_layout                      = "en-us"
  kvm_arguments                        = null
  mac_addresses                        = ["00:00:00:00:00:00", "BC:24:11:16:AC:48"]
  machine                              = null
  migrate                              = false
  name                                 = "prod-ubsrv-2"
  network_device = [{
    bridge       = "vmbr0"
    disconnected = false
    enabled      = true
    firewall     = false
    mac_address  = "BC:24:11:16:AC:48"
    model        = "virtio"
    mtu          = 0
    queues       = 0
    rate_limit   = 0
    trunks       = ""
    vlan_id      = 1
  }]
  node_name           = "Smaug"
  on_boot             = true
  pool_id             = null
  protection          = false
  purge_on_destroy    = true
  reboot              = false
  reboot_after_update = true
  scsi_hardware       = "virtio-scsi-pci"
  started             = true
  stop_on_destroy     = false
  tablet_device       = true
  tags                = []
  template            = false
  timeout_clone       = 1800
  timeout_create      = 1800
  timeout_migrate     = 1800
  timeout_reboot      = 1800
  timeout_shutdown_vm = 1800
  timeout_start_vm    = 1800
  timeout_stop_vm     = 300
  vm_id               = 115
  agent {
    enabled = true
    timeout = "15m"
    trim    = false
    type    = "virtio"
  }
  cpu {
    affinity     = null
    architecture = null
    cores        = 4
    flags        = []
    hotplugged   = 0
    limit        = 0
    numa         = false
    sockets      = 1
    type         = "x86-64-v2-AES"
    units        = 1024 # fixed: was 0
  }
  disk {
    aio               = "io_uring"
    backup            = true
    cache             = "none"
    datastore_id      = "vm-ceph"
    discard           = "on"
    file_format       = "raw"
    file_id           = null
    import_from       = null
    interface         = "virtio0"
    iothread          = true
    path_in_datastore = "vm-115-disk-0"
    replicate         = true
    serial            = null
    size              = 40
    ssd               = false
  }
  initialization {
    datastore_id = "local-lvm"
    interface    = "ide2"
    dns {
      domain  = null
      servers = ["192.168.5.5", "192.168.5.6"]
    }
    ip_config {
      ipv4 {
        address = "192.168.5.43/24"
        gateway = "192.168.5.1"
      }
    }
    user_account {
      keys     = [var.ssh_public_key]
      password = var.vm_password
      username = var.vm_username
    }
  }
  memory {
    dedicated      = 4096
    floating       = 0
    hugepages      = null
    keep_hugepages = false
    shared         = 0
  }
}

# __generated__ by Terraform
resource "proxmox_virtual_environment_vm" "prod-ubsrv-3" {
  acpi                                 = true
  bios                                 = "seabios"
  boot_order                           = ["virtio0", "net0"]
  delete_unreferenced_disks_on_destroy = true
  description                          = null
  hook_script_file_id                  = null
  keyboard_layout                      = "en-us"
  kvm_arguments                        = null
  mac_addresses                        = ["00:00:00:00:00:00", "BC:24:11:BF:12:6C"]
  machine                              = null
  migrate                              = false
  name                                 = "prod-ubsrv-3"
  network_device = [{
    bridge       = "vmbr0"
    disconnected = false
    enabled      = true
    firewall     = false
    mac_address  = "BC:24:11:BF:12:6C"
    model        = "virtio"
    mtu          = 0
    queues       = 0
    rate_limit   = 0
    trunks       = ""
    vlan_id      = 0
  }]
  node_name           = "toothless"
  on_boot             = true
  pool_id             = null
  protection          = false
  purge_on_destroy    = true
  reboot              = false
  reboot_after_update = true
  scsi_hardware       = "virtio-scsi-pci"
  started             = true
  stop_on_destroy     = false
  tablet_device       = true
  tags                = []
  template            = false
  timeout_clone       = 1800
  timeout_create      = 1800
  timeout_migrate     = 1800
  timeout_reboot      = 1800
  timeout_shutdown_vm = 1800
  timeout_start_vm    = 1800
  timeout_stop_vm     = 300
  vm_id               = 114
  agent {
    enabled = true
    timeout = "15m"
    trim    = false
    type    = "virtio"
  }
  cpu {
    affinity     = null
    architecture = null
    cores        = 4
    flags        = []
    hotplugged   = 0
    limit        = 0
    numa         = false
    sockets      = 1
    type         = "x86-64-v2-AES"
    units        = 1024 # fixed: was 0
  }
  disk {
    aio               = "io_uring"
    backup            = true
    cache             = "none"
    datastore_id      = "vm-ceph"
    discard           = "on"
    file_format       = "raw"
    file_id           = null
    import_from       = null
    interface         = "virtio0"
    iothread          = true
    path_in_datastore = "vm-114-disk-0"
    replicate         = true
    serial            = null
    size              = 40
    ssd               = false
  }
  initialization {
    datastore_id = "local-lvm"
    interface    = "ide2"
    dns {
      domain  = null
      servers = ["192.168.5.5", "192.168.5.6"]
    }
    ip_config {
      ipv4 {
        address = "192.168.5.42/24"
        gateway = "192.168.5.1"
      }
    }
    user_account {
      keys     = [var.ssh_public_key]
      password = var.vm_password
      username = var.vm_username
    }
  }
  memory {
    dedicated      = 4096
    floating       = 0
    hugepages      = null
    keep_hugepages = false
    shared         = 0
  }
}

# __generated__ by Terraform
# NOTE: name changed from "haos14.0" to "haos14" - Proxmox uses .0 for versioning, not Terraform
resource "proxmox_virtual_environment_vm" "haos14" {
  acpi                                 = true
  bios                                 = "ovmf"
  boot_order                           = ["scsi0"]
  delete_unreferenced_disks_on_destroy = true
  description                          = "Home Assistant OS\n"
  hook_script_file_id                  = null
  keyboard_layout                      = null
  kvm_arguments                        = null
  mac_addresses                        = ["00:00:00:00:00:00", "02:49:69:8F:EC:15"]
  machine                              = null
  migrate                              = false
  name                                 = "haos14"
  network_device = [{
    bridge       = "vmbr0"
    disconnected = false
    enabled      = true
    firewall     = false
    mac_address  = "02:49:69:8F:EC:15"
    model        = "virtio"
    mtu          = 0
    queues       = 0
    rate_limit   = 0
    trunks       = ""
    vlan_id      = 5
  }]
  node_name           = "Smaug"
  on_boot             = true
  pool_id             = null
  protection          = false
  purge_on_destroy    = true
  reboot              = false
  reboot_after_update = true
  scsi_hardware       = "virtio-scsi-pci"
  started             = true
  stop_on_destroy     = false
  tablet_device       = false
  tags                = ["proxmox-helper-scripts"]
  template            = false
  timeout_clone       = 1800
  timeout_create      = 1800
  timeout_migrate     = 1800
  timeout_reboot      = 1800
  timeout_shutdown_vm = 1800
  timeout_start_vm    = 1800
  timeout_stop_vm     = 300
  vm_id               = 107
  agent {
    enabled = true
    timeout = "15m"
    trim    = false
    type    = null
  }
  cpu {
    affinity     = null
    architecture = null
    cores        = 2
    flags        = []
    hotplugged   = 0
    limit        = 0
    numa         = false
    sockets      = 1
    type         = "host"
    units        = 1024 # fixed: was 0
  }
  disk {
    aio               = "io_uring"
    backup            = true
    cache             = "writethrough"
    datastore_id      = "local-lvm"
    discard           = "on"
    file_format       = "raw"
    file_id           = null
    import_from       = null
    interface         = "scsi0"
    iothread          = false
    path_in_datastore = "vm-107-disk-1"
    replicate         = true
    serial            = null
    size              = 32
    ssd               = true
  }
  efi_disk {
    datastore_id      = "local-lvm"
    file_format       = "raw"
    pre_enrolled_keys = false
    type              = "4m"
  }
  memory {
    dedicated      = 4096
    floating       = 0
    hugepages      = null
    keep_hugepages = false
    shared         = 0
  }
  operating_system {
    type = "l26"
  }
}

# __generated__ by Terraform
resource "proxmox_virtual_environment_vm" "prod-debsrv" {
  acpi                                 = true
  bios                                 = "seabios"
  boot_order                           = ["virtio0", "net0"]
  delete_unreferenced_disks_on_destroy = true
  description                          = null
  hook_script_file_id                  = null
  keyboard_layout                      = "en-us"
  kvm_arguments                        = null
  mac_addresses                        = ["00:00:00:00:00:00", "BC:24:11:C0:D1:92"]
  machine                              = null
  migrate                              = false
  name                                 = "prod-debsrv"
  network_device = [{
    bridge       = "vmbr0"
    disconnected = false
    enabled      = true
    firewall     = false
    mac_address  = "BC:24:11:C0:D1:92"
    model        = "virtio"
    mtu          = 0
    queues       = 0
    rate_limit   = 0
    trunks       = ""
    vlan_id      = 0
  }]
  node_name           = "Balerion"
  on_boot             = true
  pool_id             = null
  protection          = false
  purge_on_destroy    = true
  reboot              = false
  reboot_after_update = true
  scsi_hardware       = "virtio-scsi-pci"
  started             = true
  stop_on_destroy     = false
  tablet_device       = true
  tags                = []
  template            = false
  timeout_clone       = 1800
  timeout_create      = 1800
  timeout_migrate     = 1800
  timeout_reboot      = 1800
  timeout_shutdown_vm = 1800
  timeout_start_vm    = 1800
  timeout_stop_vm     = 300
  vm_id               = 105
  agent {
    enabled = true
    timeout = "15m"
    trim    = false
    type    = "virtio"
  }
  cpu {
    affinity     = null
    architecture = null
    cores        = 4
    flags        = []
    hotplugged   = 0
    limit        = 0
    numa         = false
    sockets      = 1
    type         = "x86-64-v2-AES"
    units        = 1024 # fixed: was 0
  }
  disk {
    aio               = "io_uring"
    backup            = true
    cache             = "none"
    datastore_id      = "vm-ceph"
    discard           = "on"
    file_format       = "raw"
    file_id           = null
    import_from       = null
    interface         = "virtio0"
    iothread          = true
    path_in_datastore = "vm-105-disk-0"
    replicate         = true
    serial            = null
    size              = 35
    ssd               = false
  }
  initialization {
    datastore_id = "vm-ceph"
    interface    = "ide2"
    dns {
      domain  = null
      servers = ["192.168.5.5", "192.168.5.6"]
    }
    ip_config {
      ipv4 {
        address = "192.168.5.48/24"
        gateway = "192.168.5.1"
      }
    }
    user_account {
      keys     = [var.ssh_public_key]
      password = var.vm_password
      username = var.vm_username
    }
  }
  memory {
    dedicated      = 4096
    floating       = 0
    hugepages      = null
    keep_hugepages = false
    shared         = 0
  }
}

# __generated__ by Terraform
resource "proxmox_virtual_environment_vm" "dev-ubsrv" {
  acpi                                 = true
  bios                                 = "seabios"
  boot_order                           = ["virtio0", "net0"]
  delete_unreferenced_disks_on_destroy = true
  description                          = null
  hook_script_file_id                  = null
  keyboard_layout                      = "en-us"
  kvm_arguments                        = null
  mac_addresses                        = ["00:00:00:00:00:00", "BC:24:11:7C:98:DF"]
  machine                              = null
  migrate                              = false
  name                                 = "dev-ubsrv"
  network_device = [{
    bridge       = "vmbr0"
    disconnected = false
    enabled      = true
    firewall     = false
    mac_address  = "BC:24:11:7C:98:DF"
    model        = "virtio"
    mtu          = 0
    queues       = 0
    rate_limit   = 0
    trunks       = ""
    vlan_id      = 0
  }]
  node_name           = "toothless"
  on_boot             = true
  pool_id             = null
  protection          = false
  purge_on_destroy    = true
  reboot              = false
  reboot_after_update = true
  scsi_hardware       = "virtio-scsi-pci"
  started             = true
  stop_on_destroy     = false
  tablet_device       = true
  tags                = []
  template            = false
  timeout_clone       = 1800
  timeout_create      = 1800
  timeout_migrate     = 1800
  timeout_reboot      = 1800
  timeout_shutdown_vm = 1800
  timeout_start_vm    = 1800
  timeout_stop_vm     = 300
  vm_id               = 116
  agent {
    enabled = true
    timeout = "15m"
    trim    = false
    type    = "virtio"
  }
  cpu {
    affinity     = null
    architecture = null
    cores        = 4
    flags        = []
    hotplugged   = 0
    limit        = 0
    numa         = false
    sockets      = 1
    type         = "x86-64-v2-AES"
    units        = 1024 # fixed: was 0
  }
  disk {
    aio               = "io_uring"
    backup            = true
    cache             = "none"
    datastore_id      = "vm-ceph"
    discard           = "on"
    file_format       = "raw"
    file_id           = null
    import_from       = null
    interface         = "virtio0"
    iothread          = true
    path_in_datastore = "vm-116-disk-0"
    replicate         = true
    serial            = null
    size              = 20
    ssd               = false
  }
  initialization {
    datastore_id = "local-lvm"
    interface    = "ide2"
    dns {
      domain  = null
      servers = ["192.168.5.5", "192.168.5.6"]
    }
    ip_config {
      ipv4 {
        address = "192.168.5.45/24"
        gateway = "192.168.5.1"
      }
    }
    user_account {
      keys     = [var.ssh_public_key]
      password = var.vm_password
      username = var.vm_username
    }
  }
  memory {
    dedicated      = 4096
    floating       = 0
    hugepages      = null
    keep_hugepages = false
    shared         = 0
  }
}

# __generated__ by Terraform
# Please review these resources and move them into your main configuration files.

# __generated__ by Terraform
resource "proxmox_virtual_environment_vm" "addyWin01" {
  acpi                                 = true
  bios                                 = "ovmf"
  boot_order                           = ["ide0", "ide2", "net0"]
  delete_unreferenced_disks_on_destroy = true
  description                          = null
  hook_script_file_id                  = null
  keyboard_layout                      = null
  kvm_arguments                        = null
  mac_addresses                        = ["BC:24:11:2D:93:27"]
  machine                              = "pc-q35-9.0"
  migrate                              = false
  name                                 = "addyWin01"
  network_device = [{
    bridge       = "vmbr0"
    disconnected = false
    enabled      = true
    enabled      = true
    firewall     = true
    mac_address  = "BC:24:11:2D:93:27"
    model        = "e1000"
    mtu          = 0
    queues       = 0
    rate_limit   = 0
    trunks       = ""
    vlan_id      = 3
  }]
  node_name           = "toothless"
  on_boot             = false
  pool_id             = null
  protection          = false
  purge_on_destroy    = true
  reboot              = false
  reboot_after_update = true
  scsi_hardware       = "virtio-scsi-single"
  started             = false
  stop_on_destroy     = false
  tablet_device       = true
  tags                = []
  template            = false
  timeout_clone       = 1800
  timeout_create      = 1800
  timeout_migrate     = 1800
  timeout_reboot      = 1800
  timeout_shutdown_vm = 1800
  timeout_start_vm    = 1800
  timeout_stop_vm     = 300
  vm_id               = 113
  agent {
    enabled = true
    timeout = "15m"
    trim    = false
    type    = null
  }
  cpu {
    affinity     = null
    architecture = null
    cores        = 4
    flags        = []
    hotplugged   = 0
    limit        = 0
    numa         = false
    sockets      = 1
    type         = "x86-64-v2-AES"
    units        = 1024
  }
  disk {
    aio               = "io_uring"
    backup            = true
    cache             = "none"
    datastore_id      = "local-lvm"
    discard           = "ignore"
    file_format       = "raw"
    file_id           = null
    import_from       = null
    interface         = "ide0"
    iothread          = false
    path_in_datastore = "vm-113-disk-1"
    replicate         = true
    serial            = null
    size              = 64
    ssd               = false
  }
  efi_disk {
    datastore_id      = "local-lvm"
    file_format       = "raw"
    pre_enrolled_keys = true
    type              = "4m"
  }
  memory {
    dedicated      = 8192
    floating       = 0
    hugepages      = null
    keep_hugepages = false
    shared         = 0
  }
  operating_system {
    type = "win11"
  }
}

# __generated__ by Terraform
resource "proxmox_virtual_environment_vm" "fedsr02" {
  acpi                                 = true
  bios                                 = "seabios"
  boot_order                           = ["scsi0", "net0"]  # removed ide2 ISO from boot
  delete_unreferenced_disks_on_destroy = true
  keyboard_layout                      = "en-us"
  machine                              = null
  migrate                              = false
  name                                 = "fedsr02"
  network_device = [{
    bridge       = "vmbr0"
    disconnected = false
    enabled      = true
    firewall     = true
    mac_address  = "BC:24:11:37:91:68"
    model        = "virtio"
    mtu          = 0
    queues       = 0
    rate_limit   = 0
    trunks       = ""
    vlan_id      = 0
  }]
  node_name           = "Smaug"
  on_boot             = true
  pool_id             = null
  protection          = false
  purge_on_destroy    = true
  reboot              = false
  reboot_after_update = true
  scsi_hardware       = "virtio-scsi-single"
  started             = true
  stop_on_destroy     = false
  tablet_device       = true
  tags                = []
  template            = false
  timeout_clone       = 1800
  timeout_create      = 1800
  timeout_migrate     = 1800
  timeout_reboot      = 1800
  timeout_shutdown_vm = 1800
  timeout_start_vm    = 1800
  timeout_stop_vm     = 300
  vm_id               = 108
  agent {
    enabled = false  # matches current config
    timeout = "15m"
    trim    = false
    type    = "virtio"
  }
  cpu {
    affinity     = null
    architecture = null
    cores        = 2
    flags        = []
    hotplugged   = 0
    limit        = 0
    numa         = false
    sockets      = 1
    type         = "x86-64-v2-AES"
    units        = 1024
  }
  disk {
    aio               = "io_uring"
    backup            = true
    cache             = "none"
    datastore_id      = "vm-ceph"
    discard           = "on"
    file_format       = "raw"
    file_id           = null
    import_from       = null
    interface         = "scsi0"
    iothread          = true
    path_in_datastore = "vm-108-disk-0"
    replicate         = true
    serial            = null
    size              = 40
    ssd               = false
  }
  initialization {
    datastore_id = "local-lvm"
    interface    = "ide0"
    dns {
      domain  = null
      servers = ["192.168.5.5", "192.168.5.6"]
    }
    ip_config {
      ipv4 {
        address = "192.168.5.27/24" 
        gateway = "192.168.5.1"
      }
    }
    user_account {
      keys     = [var.ssh_public_key]
      password = var.vm_password
      username = var.vm_username
    }
  }
  memory {
    dedicated      = 8192
    floating       = 0
    hugepages      = null
    keep_hugepages = false
    shared         = 0
  }
  operating_system {
    type = "l26"
  }
}

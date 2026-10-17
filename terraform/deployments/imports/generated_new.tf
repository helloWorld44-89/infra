# __generated__ by Terraform
# Please review these resources and move them into your main configuration files.

# __generated__ by Terraform from "toothless/112"
resource "proxmox_virtual_environment_container" "pisrv02" {
  delete_unreferenced_disks_on_destroy = false
  description                          = "Pihole LXC\n"
  environment_variables                = {}
  hook_script_file_id                  = null
  node_name                            = "toothless"
  pool_id                              = null
  protection                           = false
  purge_on_destroy                     = true
  start_on_boot                        = true
  started                              = true
  tags                                 = ["proxmox-helper-scripts"]
  template                             = false
  timeout_clone                        = 1800
  timeout_create                       = 1800
  timeout_delete                       = 60
  timeout_update                       = 1800
  unprivileged                         = false
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
    size          = 10
  }
  features {
    fuse    = false
    keyctl  = false
    mknod   = false
    mount   = []
    nesting = true
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
    bridge       = "vmbr0"
    enabled      = true
    firewall     = false
    host_managed = false
    mac_address  = "BC:24:11:79:94:8E"
    mtu          = 0
    name         = "eth0"
    rate_limit   = 0
    vlan_id      = 4
  }
  network_interface {
    bridge       = "vmbr0"
    enabled      = true
    firewall     = false
    host_managed = false
    mac_address  = "BC:24:11:87:48:26"
    mtu          = 0
    name         = "net3"
    rate_limit   = 0
    vlan_id      = 3
  }
  network_interface {
    bridge       = "vmbr0"
    enabled      = true
    firewall     = false
    host_managed = false
    mac_address  = "BC:24:11:4E:BF:19"
    mtu          = 0
    name         = "net10"
    rate_limit   = 0
    vlan_id      = 10
  }
  network_interface {
    bridge       = "vmbr0"
    enabled      = true
    firewall     = false
    host_managed = false
    mac_address  = "BC:24:11:2F:2D:99"
    mtu          = 0
    name         = "net5"
    rate_limit   = 0
    vlan_id      = 0
  }
  operating_system {
    template_file_id = ""
    type             = "debian"
  }
}

# __generated__ by Terraform
resource "proxmox_virtual_environment_vm" "prod-k3s-3" {
  acpi                                 = true
  bios                                 = "seabios"
  boot_order                           = ["virtio0", "net0"]
  delete_unreferenced_disks_on_destroy = true
  description                          = null
  hook_script_file_id                  = null
  keyboard_layout                      = "en-us"
  kvm_arguments                        = null
  mac_addresses                        = ["00:00:00:00:00:00", "BC:24:11:F1:EC:9A", "82:6A:F7:D6:19:A4", "D6:C9:76:FC:73:D6", "1E:55:CA:D6:12:BF", "CE:4E:D5:9E:B8:4B"]
  machine                              = null
  migrate                              = false
  name                                 = "prod-k3s-3"
  network_device = [{
    bridge       = "vmbr0"
    disconnected = false
    enabled      = true
    firewall     = false
    mac_address  = "BC:24:11:F1:EC:9A"
    model        = "virtio"
    mtu          = 0
    queues       = 0
    rate_limit   = 0
    trunks       = ""
    vlan_id      = 1
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
    cores        = 4
    flags        = []
    hotplugged   = 0
    limit        = 0
    numa         = false
    sockets      = 1
    type         = "x86-64-v2-AES"
    units        = 1024 # fixed: was 0 (provider generate-config bug)
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
    path_in_datastore = "vm-100-disk-0"
    queues            = 0
    replicate         = true
    serial            = null
    size              = 50
    ssd               = false
  }
  initialization {
    datastore_id = "vm-ceph"
    interface    = "ide2"
    upgrade      = true
    dns {
      domain  = null
      servers = ["192.168.5.5", "192.168.5.6"]
    }
    ip_config {
      ipv4 {
        address = "192.168.5.62/24"
        gateway = "192.168.5.1"
      }
    }
    user_account {
      keys     = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAlqJZrcj9rFZjPoqZ5cm9OL9a1JKstvMplYdSKZ8P7N proxmox-terraform"]
      password = null # sensitive
      username = "jconder44"
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
resource "proxmox_virtual_environment_vm" "prod-k3s-1" {
  acpi                                 = true
  bios                                 = "seabios"
  boot_order                           = ["virtio0", "net0"]
  delete_unreferenced_disks_on_destroy = true
  description                          = null
  hook_script_file_id                  = null
  keyboard_layout                      = "en-us"
  kvm_arguments                        = null
  mac_addresses                        = ["00:00:00:00:00:00", "BC:24:11:79:BB:6D", "6E:EC:7B:6C:F3:47", "E2:A4:59:10:7B:D8", "96:1A:57:18:5F:C1", "EA:2D:6F:7E:47:46", "2E:96:37:49:A8:55", "52:AC:C0:A8:2C:A9", "1A:90:BA:FD:D4:49", "EA:F6:69:2B:2E:03", "32:EB:32:91:6A:07", "46:FA:93:F9:E6:F2", "66:FC:DF:C3:05:19", "66:27:07:F0:2D:D9", "56:EE:CB:9B:B9:C1", "76:B6:28:02:11:19", "0A:F4:78:8A:11:33", "02:44:D6:DE:B6:C4", "66:EF:93:B1:AE:18"]
  machine                              = null
  migrate                              = false
  name                                 = "prod-k3s-1"
  network_device = [{
    bridge       = "vmbr0"
    disconnected = false
    enabled      = true
    firewall     = false
    mac_address  = "BC:24:11:79:BB:6D"
    model        = "virtio"
    mtu          = 0
    queues       = 0
    rate_limit   = 0
    trunks       = ""
    vlan_id      = 1
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
  vm_id               = 102
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
    units        = 1024 # fixed: was 0 (provider generate-config bug)
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
    path_in_datastore = "vm-102-disk-0"
    queues            = 0
    replicate         = true
    serial            = null
    size              = 50
    ssd               = false
  }
  initialization {
    datastore_id = "vm-ceph"
    interface    = "ide2"
    upgrade      = true
    dns {
      domain  = null
      servers = ["192.168.5.5", "192.168.5.6"]
    }
    ip_config {
      ipv4 {
        address = "192.168.5.60/24"
        gateway = "192.168.5.1"
      }
    }
    user_account {
      keys     = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAlqJZrcj9rFZjPoqZ5cm9OL9a1JKstvMplYdSKZ8P7N proxmox-terraform"]
      password = null # sensitive
      username = "jconder44"
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

# __generated__ by Terraform from "Smaug/105"
resource "proxmox_virtual_environment_vm" "prod-debsrv" {
  acpi                                 = true
  bios                                 = "seabios"
  boot_order                           = ["virtio0", "net0"]
  delete_unreferenced_disks_on_destroy = true
  description                          = null
  hook_script_file_id                  = null
  keyboard_layout                      = "en-us"
  kvm_arguments                        = null
  mac_addresses                        = ["00:00:00:00:00:00", "BC:24:11:C0:D1:92", "CA:75:B6:F9:DE:69", "7E:79:A7:47:3C:DD", "9A:A5:F7:40:0D:57", "E2:60:FB:BB:48:2C", "1E:B7:94:A5:99:55", "D6:51:D5:12:08:DB", "5A:EB:16:96:CB:CB"]
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
  node_name           = "Balerion" # updated 2026-10-05: HA-relocated from Smaug, see main.tf note
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
    interface         = "virtio0"
    iothread          = true
    path_in_datastore = "vm-105-disk-0"
    queues            = 0
    replicate         = true
    serial            = null
    size              = 35
    ssd               = false
  }
  initialization {
    datastore_id = "vm-ceph"
    interface    = "ide2"
    upgrade      = true
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
      keys     = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAlqJZrcj9rFZjPoqZ5cm9OL9a1JKstvMplYdSKZ8P7N proxmox-terraform"]
      password = null # sensitive
      username = "jconder44"
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
resource "proxmox_virtual_environment_vm" "prod-k3s-2" {
  acpi                                 = true
  bios                                 = "seabios"
  boot_order                           = ["virtio0", "net0"]
  delete_unreferenced_disks_on_destroy = true
  description                          = null
  hook_script_file_id                  = null
  keyboard_layout                      = "en-us"
  kvm_arguments                        = null
  mac_addresses                        = ["00:00:00:00:00:00", "BC:24:11:62:D5:99", "CA:C4:5B:0B:12:23", "12:0E:3B:14:10:AF", "F2:93:9F:86:CE:52", "1A:33:E2:EF:9B:C4", "76:68:E5:FC:30:D0", "3A:C7:2C:83:CC:B4", "B2:B1:0F:6D:24:AF", "9E:A1:D4:F5:00:7C", "6A:00:D4:0B:54:2A", "7A:1C:E9:13:21:CB", "66:D3:26:A8:D2:56", "AE:11:7F:3F:14:0A", "46:CC:F5:48:00:4E", "EA:4A:5D:CB:E6:42", "A2:48:5E:48:4F:4C", "92:7C:5C:73:2C:17", "DA:DE:DA:5F:43:31", "BA:2F:55:DA:9D:CC", "AA:65:12:47:13:34"]
  machine                              = null
  migrate                              = false
  name                                 = "prod-k3s-2"
  network_device = [{
    bridge       = "vmbr0"
    disconnected = false
    enabled      = true
    firewall     = false
    mac_address  = "BC:24:11:62:D5:99"
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
  vm_id               = 101
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
    units        = 1024 # fixed: was 0 (provider generate-config bug)
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
    path_in_datastore = "vm-101-disk-0"
    queues            = 0
    replicate         = true
    serial            = null
    size              = 50
    ssd               = false
  }
  initialization {
    datastore_id = "vm-ceph"
    interface    = "ide2"
    upgrade      = true
    dns {
      domain  = null
      servers = ["192.168.5.5", "192.168.5.6"]
    }
    ip_config {
      ipv4 {
        address = "192.168.5.61/24"
        gateway = "192.168.5.1"
      }
    }
    user_account {
      keys     = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAlqJZrcj9rFZjPoqZ5cm9OL9a1JKstvMplYdSKZ8P7N proxmox-terraform"]
      password = null # sensitive
      username = "jconder44"
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
resource "proxmox_virtual_environment_vm" "prod-k3s-master" {
  acpi                                 = true
  bios                                 = "seabios"
  boot_order                           = ["virtio0", "net0"]
  delete_unreferenced_disks_on_destroy = true
  description                          = null
  hook_script_file_id                  = null
  keyboard_layout                      = "en-us"
  kvm_arguments                        = null
  mac_addresses                        = ["00:00:00:00:00:00", "BC:24:11:ED:CC:B7", "4A:41:42:57:D9:C1", "C6:73:43:36:24:F5", "E2:DD:42:5E:82:79", "EA:3C:4E:94:71:60", "6E:8F:4F:57:69:D4", "72:2B:FD:46:B8:F3", "5E:AC:04:A8:F3:66", "1E:3B:3E:4D:E2:4B"]
  machine                              = null
  migrate                              = false
  name                                 = "prod-k3s-master"
  network_device = [{
    bridge       = "vmbr0"
    disconnected = false
    enabled      = true
    firewall     = false
    mac_address  = "BC:24:11:ED:CC:B7"
    model        = "virtio"
    mtu          = 0
    queues       = 0
    rate_limit   = 0
    trunks       = ""
    vlan_id      = 1
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
  vm_id               = 104
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
    units        = 1024 # fixed: was 0 (provider generate-config bug)
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
    path_in_datastore = "vm-104-disk-0"
    queues            = 0
    replicate         = true
    serial            = null
    size              = 32
    ssd               = false
  }
  initialization {
    datastore_id = "vm-ceph"
    interface    = "ide2"
    upgrade      = true
    dns {
      domain  = null
      servers = ["192.168.5.5", "192.168.5.6"]
    }
    ip_config {
      ipv4 {
        address = "192.168.5.65/24"
        gateway = "192.168.5.1"
      }
    }
    user_account {
      keys     = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAlqJZrcj9rFZjPoqZ5cm9OL9a1JKstvMplYdSKZ8P7N proxmox-terraform"]
      password = null # sensitive
      username = "jconder44"
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

# __generated__ by Terraform from "toothless/117"
resource "proxmox_virtual_environment_vm" "prod-ubsrv-1" {
  acpi                                 = true
  bios                                 = "seabios"
  boot_order                           = ["virtio0", "net0"]
  delete_unreferenced_disks_on_destroy = true
  description                          = null
  hook_script_file_id                  = null
  keyboard_layout                      = "en-us"
  kvm_arguments                        = null
  mac_addresses                        = ["00:00:00:00:00:00", "BC:24:11:13:2B:96", "BE:E8:E6:C6:DB:38", "6E:39:F1:23:98:6D", "E6:20:2E:6D:A0:1C", "52:C0:C9:55:F5:31", "66:02:C1:0F:FB:04", "4A:CF:91:2B:E7:AF", "86:85:41:13:71:78", "72:E3:3C:31:8C:60", "4E:FB:19:B2:24:7F", "5A:1A:B2:96:E9:89", "EA:78:55:85:08:9F", "B2:1C:F5:89:7A:26", "8E:D1:AE:E3:74:F0", "1A:04:07:D4:48:6D", "96:8F:63:CB:07:C5", "46:EF:37:B6:97:A5", "32:06:9B:1D:9F:2B", "4E:41:8B:E4:32:A3", "36:CA:8B:FC:47:7E", "9A:06:88:A3:BE:EF", "AE:3A:EC:A4:D3:70", "32:50:55:B1:01:83"]
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
    interface         = "virtio0"
    iothread          = true
    path_in_datastore = "vm-117-disk-0"
    queues            = 0
    replicate         = true
    serial            = null
    size              = 40
    ssd               = false
  }
  initialization {
    datastore_id = "vm-ceph"
    interface    = "ide2"
    upgrade      = true
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
      keys     = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAlqJZrcj9rFZjPoqZ5cm9OL9a1JKstvMplYdSKZ8P7N proxmox-terraform"]
      password = null # sensitive
      username = "jconder44"
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
resource "proxmox_virtual_environment_vm" "prod-agents-01" {
  acpi                                 = true
  bios                                 = "seabios"
  boot_order                           = ["virtio0", "net0"]
  delete_unreferenced_disks_on_destroy = true
  description                          = null
  hook_script_file_id                  = null
  keyboard_layout                      = "en-us"
  kvm_arguments                        = null
  mac_addresses                        = ["00:00:00:00:00:00", "BC:24:11:19:98:9B"]
  machine                              = null
  migrate                              = false
  name                                 = "prod-agents-01"
  network_device = [{
    bridge       = "vmbr0"
    disconnected = false
    enabled      = true
    firewall     = false
    mac_address  = "BC:24:11:19:98:9B"
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
  vm_id               = 106
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
    units        = 1024 # fixed: was 0 (provider generate-config bug)
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
    path_in_datastore = "vm-106-disk-0"
    queues            = 0
    replicate         = true
    serial            = null
    size              = 100
    ssd               = false
  }
  initialization {
    datastore_id = "vm-ceph"
    interface    = "ide2"
    upgrade      = true
    dns {
      domain  = null
      servers = ["192.168.5.5", "192.168.5.6"]
    }
    ip_config {
      ipv4 {
        address = "192.168.5.99/24"
        gateway = "192.168.5.1"
      }
    }
    user_account {
      keys     = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAlqJZrcj9rFZjPoqZ5cm9OL9a1JKstvMplYdSKZ8P7N proxmox-terraform"]
      password = null # sensitive
      username = "jconder44"
    }
  }
  memory {
    dedicated      = 10240
    floating       = 0
    hugepages      = null
    keep_hugepages = false
    shared         = 0
  }
}

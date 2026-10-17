# __generated__ by Terraform
# Please review these resources and move them into your main configuration files.

# __generated__ by Terraform from "toothless/103"
resource "proxmox_virtual_environment_container" "pisrv01" {
  delete_unreferenced_disks_on_destroy = false
  description                          = "<div align='center'>\n  <a href='https://community-scripts.org' target='_blank' rel='noopener noreferrer'>\n    <img src='https://raw.githubusercontent.com/community-scripts/ProxmoxVE/main/misc/images/logo-81x112.png' alt='Logo' style='width:81px;height:112px;'/>\n  </a>\n\n  <h2 style='font-size: 24px; margin: 20px 0;'>Pihole LXC</h2>\n\n  <p style='margin: 16px 0;'>\n    <a href='https://community-scripts.org/donate' target='_blank' rel='noopener noreferrer'>\n      <img src='https://img.shields.io/badge/������-Sponsoring%20%26%20Donations-FF5E5B' alt='Sponsoring and donations' />\n    </a>\n  </p>\n\n  <p style='margin: 12px 0;'>\n    <a href='https://community-scripts.org/scripts/pihole' target='_blank' rel='noopener noreferrer'>\n      <img src='https://img.shields.io/badge/����-Open%20Script%20Page-00617f' alt='Open script page' />\n    </a>\n  </p>\n\n  <span style='margin: 0 10px;'>\n    <i class=\"fa fa-github fa-fw\" style=\"color: #f5f5f5;\"></i>\n    <a href='https://github.com/community-scripts/ProxmoxVE' target='_blank' rel='noopener noreferrer' style='text-decoration: none; color: #00617f;'>GitHub</a>\n  </span>\n  <span style='margin: 0 10px;'>\n    <i class=\"fa fa-comments fa-fw\" style=\"color: #f5f5f5;\"></i>\n    <a href='https://github.com/community-scripts/ProxmoxVE/discussions' target='_blank' rel='noopener noreferrer' style='text-decoration: none; color: #00617f;'>Discussions</a>\n  </span>\n  <span style='margin: 0 10px;'>\n    <i class=\"fa fa-exclamation-circle fa-fw\" style=\"color: #f5f5f5;\"></i>\n    <a href='https://github.com/community-scripts/ProxmoxVE/issues' target='_blank' rel='noopener noreferrer' style='text-decoration: none; color: #00617f;'>Issues</a>\n  </span>\n</div>\n"
  environment_variables                = {}
  hook_script_file_id                  = null
  node_name                            = "toothless"
  pool_id                              = null
  protection                           = false
  purge_on_destroy                     = true
  start_on_boot                        = true
  started                              = true
  tags                                 = ["adblock", "community-script", "dns"]
  template                             = false
  timeout_clone                        = 1800
  timeout_create                       = 1800
  timeout_delete                       = 60
  timeout_update                       = 1800
  unprivileged                         = true
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
    keyctl  = true
    mknod   = false
    mount   = []
    nesting = true
  }
  initialization {
    entrypoint = null
    hostname   = "pisrv03"
    ip_config {
      ipv4 {
        address = "192.168.5.5/24"
        gateway = "192.168.5.1"
      }
    }
    ip_config {
      ipv4 {
        address = "192.168.4.13/24"
        gateway = "192.168.4.1"
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
        address = "192.168.3.5/24"
        gateway = "192.168.3.1"
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
    mac_address  = "BC:24:11:AE:CA:0B"
    mtu          = 0
    name         = "eth0"
    rate_limit   = 0
    vlan_id      = 0
  }
  network_interface {
    bridge       = "vmbr0"
    enabled      = true
    firewall     = false
    host_managed = false
    mac_address  = "BC:24:11:7D:9C:91"
    mtu          = 0
    name         = "Trusted"
    rate_limit   = 0
    vlan_id      = 4
  }
  network_interface {
    bridge       = "vmbr0"
    enabled      = true
    firewall     = false
    host_managed = false
    mac_address  = "BC:24:11:78:59:2F"
    mtu          = 0
    name         = "IOT"
    rate_limit   = 0
    vlan_id      = 10
  }
  network_interface {
    bridge       = "vmbr0"
    enabled      = true
    firewall     = false
    host_managed = false
    mac_address  = "BC:24:11:5B:7C:21"
    mtu          = 0
    name         = "Guest"
    rate_limit   = 0
    vlan_id      = 3
  }
  operating_system {
    template_file_id = ""
    type             = "debian"
  }
}

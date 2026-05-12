terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "~> 0.66"
    }
  }
}

resource "proxmox_virtual_environment_download_file" "ubuntu_cloud_image" {
  count        = length(var.prox_nodes)
  content_type = "import"
  datastore_id = "local"
  node_name    = var.prox_nodes[count.index]
  url          = "https://cloud-images.ubuntu.com/noble/current/noble-server-cloudimg-amd64.img"
  file_name    = "noble-server-cloudimg-amd64.qcow2"
}

resource "proxmox_virtual_environment_vm" "vm" {
  count     = var.vm_count
  name      = var.vm_count > 1 ? "${var.vm_name}-${count.index + 1}" : var.vm_name
  node_name = var.prox_nodes[count.index]



  cpu {
    cores = var.vm_cores
    type  = "x86-64-v2-AES"
  }

  memory {
    dedicated = var.vm_memory
  }

  disk {
    import_from = proxmox_virtual_environment_download_file.ubuntu_cloud_image[count.index].id
    datastore_id = var.datastore
    interface    = "virtio0"
    iothread     = true
    discard      = "on"
    size         = var.vm_disk_size
  }

  network_device {
    bridge  = "vmbr0"
    model   = "virtio"
    vlan_id = var.vm_vlan
  }

  initialization {
    datastore_id = var.datastore
    ip_config {
      ipv4 {
        address = var.vm_ip[count.index]
        gateway = var.vm_gateway
      }
    }

    dns {
      servers = ["192.168.5.5","192.168.5.6"]
    }
    
    user_account {
      username = var.vm_user
      password = var.vm_password
      keys     = [var.ssh_public_key]
    }
  }

  agent {
    enabled = true
  }
  stop_on_destroy = true
  reboot          = true
  timeout_create = 120
  on_boot = true
}
terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "~> 0.66"
    }
  }
}

resource "proxmox_virtual_environment_download_file" "ubuntu_cloud_image" {
  count        = var.vm_count
  content_type = "import"
  datastore_id = "local"
  node_name    = var.prox_node[count.index % length(var.prox_node)]
  url          = "https://cloud-images.ubuntu.com/noble/current/noble-server-cloudimg-amd64.img"
  file_name    = "noble-server-cloudimg-amd64.qcow2"
  overwrite         = false    
  overwrite_unmanaged = true
}

resource "proxmox_virtual_environment_vm" "vm" {
  count     = var.vm_count
  name      = var.vm_count > 1 ? "${var.vm_name}-${count.index + 1}" : var.vm_name
  node_name = var.prox_node[count.index % length(var.prox_node)]



  cpu {
    cores = var.vm_cores
    type  = "x86-64-v2-AES"
  }

  memory {
    dedicated = var.vm_memory
  }

  # OS disk
  disk {
    import_from  = proxmox_virtual_environment_download_file.ubuntu_cloud_image[count.index].id
    datastore_id = var.datastore
    interface    = "virtio0"
    iothread     = true
    discard      = "on"
    size         = var.vm_disk_size
  }

  # Optional data disk
  dynamic "disk" {
    for_each = var.data_disk_size != null ? [1] : []
    content {
      datastore_id = coalesce(var.data_disk_datastore, var.datastore)
      interface    = "virtio1"
      iothread     = true
      discard      = "on"
      size         = var.data_disk_size
      file_format  = "raw"
    }
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
        address = var.vm_ip[count.index % length(var.vm_ip)]
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
  timeout_create = 300
  on_boot = true
}
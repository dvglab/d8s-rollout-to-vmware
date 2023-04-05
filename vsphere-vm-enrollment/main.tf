provider "vsphere" {
  vsphere_server       = var.vsphere_server
  user                 = var.vsphere_username
  password             = var.vsphere_password
  allow_unverified_ssl = var.vsphere_insecure
}

data "vsphere_datacenter" "datacenter" {
  name = var.vsphere_datacenter
}

data "vsphere_network" "network" {
  name          = var.vsphere_network
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_network" "network_ext" {
  name          = var.vsphere_ext_network
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_compute_cluster" "cluster" {
  name          = var.vsphere_cluster
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_resource_pool" "pool" {
  name          = format("%s%s", data.vsphere_compute_cluster.cluster.name, "/Resources")
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_datastore" "datastore" {
  name          = var.vsphere_datastore
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_content_library" "content_library" {
  name = var.vsphere_content_library
}

data "vsphere_content_library_item" "content_library_item" {
  name       = var.vsphere_content_library_tpl
  type       = "vm-template"
  library_id = data.vsphere_content_library.content_library.id
}

locals {
  vm_last_ip = regex("[0-9]+[.][0-9]+[.][0-9]+[.]([0-9]+)", var.vm_ipv4_address )[0]
}

resource "vsphere_virtual_machine" "vm_master" {
  count                   = var.vm_master_count
  folder                  = var.vsphere_folder
  efi_secure_boot_enabled = var.vm_efi_secure_boot_enabled
  datastore_id            = data.vsphere_datastore.datastore.id
  resource_pool_id        = data.vsphere_resource_pool.pool.id
  firmware                = var.vm_firmware
  name                    = "${var.vm_master_name}-${count.index}.${var.vm_domain}"
  num_cpus                = var.vm_master_cpus
  memory                  = var.vm_master_memory
  enable_disk_uuid        = true
  network_interface {
    network_id = data.vsphere_network.network.id
  }
  disk {
    label            = "disk0"
    size             = var.vm_master_disk_size
    thin_provisioned = true
  }
  clone {
    template_uuid = data.vsphere_content_library_item.content_library_item.id
    customize {
      linux_options {
        host_name = "${var.vm_master_hostname}-${count.index}"
        domain    = var.vm_domain
      }
      network_interface {
        ipv4_address = cidrhost("${var.vm_ipv4_address}/${var.vm_ipv4_netmask}", local.vm_last_ip + count.index)
        # regex("[0-9]+[.][0-9]+[.][0-9]+[.]([0-9]+)", "${var.vm_ipv4_address}"))
        ipv4_netmask = var.vm_ipv4_netmask
      }

      ipv4_gateway    = var.vm_ipv4_gateway
      dns_suffix_list = var.vm_dns_suffix_list
      dns_server_list = var.vm_dns_server_list
    }
  }
  lifecycle {
    ignore_changes = [
      clone[0].template_uuid,
    ]
  }
}


resource "vsphere_virtual_machine" "vm_ingress" {
  count                   = var.vm_ingress_count
  folder                  = var.vsphere_folder
  efi_secure_boot_enabled = var.vm_efi_secure_boot_enabled
  datastore_id            = data.vsphere_datastore.datastore.id
  resource_pool_id        = data.vsphere_resource_pool.pool.id
  firmware                = var.vm_firmware
  name                    = "${var.vm_ingress_name}-${count.index}.${var.vm_domain}"
  num_cpus                = var.vm_ingress_cpus
  memory                  = var.vm_ingress_memory
  enable_disk_uuid        = true
  network_interface {
    network_id = data.vsphere_network.network.id
  }
  network_interface {
    network_id = data.vsphere_network.network_ext.id
  }
  disk {
    label            = "disk0"
    size             = var.vm_ingress_disk_size
    thin_provisioned = true
  }
  clone {
    template_uuid = data.vsphere_content_library_item.content_library_item.id
    customize {
      linux_options {
        host_name = "${var.vm_ingress_hostname}-${count.index}"
        domain    = var.vm_domain
      }
      network_interface {
        ipv4_address = var.vm_ingress_ip_list[count.index]
        ipv4_netmask = var.vm_ipv4_netmask
      }
      network_interface {
        ipv4_address = var.vm_ingress_ext_ip_list[count.index]
        ipv4_netmask = var.vm_ipv4_netmask
      }
      ipv4_gateway    = var.vm_ipv4_gateway
      dns_suffix_list = var.vm_dns_suffix_list
      dns_server_list = var.vm_dns_server_list
    }
  }
  lifecycle {
    ignore_changes = [
      clone[0].template_uuid,
    ]
  }
}


resource "vsphere_virtual_machine" "vm_node" {
  count                   = var.vm_node_count
  folder                  = var.vsphere_folder
  efi_secure_boot_enabled = var.vm_efi_secure_boot_enabled
  datastore_id            = data.vsphere_datastore.datastore.id
  resource_pool_id        = data.vsphere_resource_pool.pool.id
  firmware                = var.vm_firmware
  name                    = "${var.vm_node_name}-${count.index}.${var.vm_domain}"
  num_cpus                = var.vm_node_cpus
  memory                  = var.vm_node_memory
  enable_disk_uuid        = true
  network_interface {
    network_id = data.vsphere_network.network.id
  }
  disk {
    label            = "disk0"
    size             = var.vm_node_disk_size
    thin_provisioned = true
  }
  disk {
    label            = "disk1"
    size             = var.vm_node_disk1_size[count.index]
    thin_provisioned = true
    unit_number = 1
  }
  clone {
    template_uuid = data.vsphere_content_library_item.content_library_item.id
    customize {
      linux_options {
        host_name = "${var.vm_node_hostname}-${count.index}"
        domain    = var.vm_domain
      }
      network_interface {
        ipv4_address = var.vm_node_ip_list[count.index]
        # regex("[0-9]+[.][0-9]+[.][0-9]+[.]([0-9]+)", "${var.vm_ipv4_address}"))
        ipv4_netmask = var.vm_ipv4_netmask
      }

      ipv4_gateway    = var.vm_ipv4_gateway
      dns_suffix_list = var.vm_dns_suffix_list
      dns_server_list = var.vm_dns_server_list
    }
  }
  lifecycle {
    ignore_changes = [
      clone[0].template_uuid,
    ]
  }
}


resource "vsphere_virtual_machine" "vm_monitoring" {
  count                   = var.vm_monitoring_count
  folder                  = var.vsphere_folder
  efi_secure_boot_enabled = var.vm_efi_secure_boot_enabled
  datastore_id            = data.vsphere_datastore.datastore.id
  resource_pool_id        = data.vsphere_resource_pool.pool.id
  firmware                = var.vm_firmware
  name                    = "${var.vm_monitoring_name}-${count.index}.${var.vm_domain}"
  num_cpus                = var.vm_monitoring_cpus
  memory                  = var.vm_monitoring_memory
  enable_disk_uuid        = true
  network_interface {
    network_id = data.vsphere_network.network.id
  }
  disk {
    label            = "disk0"
    size             = var.vm_monitoring_disk_size
    thin_provisioned = true
  }
  disk {
    label            = "disk1"
    size             = var.vm_monitoring_disk1_size[count.index]
    thin_provisioned = true
    unit_number = 1
  }
  clone {
    template_uuid = data.vsphere_content_library_item.content_library_item.id
    customize {
      linux_options {
        host_name = "${var.vm_monitoring_hostname}-${count.index}"
        domain    = var.vm_domain
      }
      network_interface {
        ipv4_address = var.vm_monitoring_ip_list[count.index]
        # regex("[0-9]+[.][0-9]+[.][0-9]+[.]([0-9]+)", "${var.vm_ipv4_address}"))
        ipv4_netmask = var.vm_ipv4_netmask
      }

      ipv4_gateway    = var.vm_ipv4_gateway
      dns_suffix_list = var.vm_dns_suffix_list
      dns_server_list = var.vm_dns_server_list
    }
  }
  lifecycle {
    ignore_changes = [
      clone[0].template_uuid,
    ]
  }
}

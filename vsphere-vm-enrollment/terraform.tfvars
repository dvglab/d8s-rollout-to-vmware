##################################################################################
# VARIABLES
##################################################################################

# Credentials

vsphere_server   = "vcenter.domain.com"
vsphere_username = "username@domain.com"
vsphere_password = "VeryStrongPass"
vsphere_insecure = true

# vSphere Settings

vsphere_datacenter          = "DC"
vsphere_cluster             = "cluster"
vsphere_datastore           = "datastore"
vsphere_folder              = "deckhouse"
vsphere_network             = "vlan100"
vsphere_ext_network         = "vlan200"
vsphere_content_library     = "Main"
vsphere_content_library_tpl = "linux-ubuntu-22.04-lts-HEAD-30-03-2023"

# General Virtual Machines Settings
vm_efi_secure_boot_enabled = false
vm_firmware                = "efi"
vm_domain                  = "d8s.domain.com"

# First IP address for master (next IPs will be incremented automatically)
vm_ipv4_address            = "10.5.1.10"
vm_ipv4_netmask            = "24"
vm_ipv4_gateway            = "10.5.1.30"
vm_dns_suffix_list         = ["domain.com" ,"domain-b.com"]
vm_dns_server_list         = ["10.5.1.30", "10.5.2.30"]

# masters
vm_master_name             = "master"
vm_master_cpus             = 4
vm_master_memory           = 8096
vm_master_disk_size        = 80
vm_master_hostname         = "master"
vm_master_count            = 3

# ingress
vm_ingress_name             = "ingress"
vm_ingress_cpus             = 4
vm_ingress_memory           = 8192
vm_ingress_disk_size        = 80
vm_ingress_hostname         = "ingress"
vm_ingress_count            = 2
vm_ingress_ip_list          = ["10.5.1.20", "10.5.1.21"]
vm_ingress_ext_ip_list      = ["5.4.197.20", "5.4.197.21"]

# nodes
vm_node_name             = "node"
vm_node_cpus             = 8
vm_node_memory           = 24576
vm_node_disk_size        = 80
vm_node_disk1_size       = [ "200", "200", "200" ]
vm_node_hostname         = "node"
vm_node_count            = 3
vm_node_ip_list          = ["10.5.1.50", "10.5.1.51", "10.5.1.52"]

# system
vm_monitoring_name             = "monitoring"
vm_monitoring_cpus             = 8
vm_monitoring_memory           = 12288
vm_monitoring_disk_size        = 60
vm_monitoring_disk1_size       = [ "200", "200" ]
vm_monitoring_hostname         = "monitoring"
vm_monitoring_count            = 2  
vm_monitoring_ip_list          = ["10.5.1.40", "10.5.1.41"]

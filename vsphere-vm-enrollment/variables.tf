##################################################################################
# VARIABLES
##################################################################################

# Credentials

variable "vsphere_server" {
  type = string
}

variable "vsphere_username" {
  type = string
}

variable "vsphere_password" {
  type = string
}

variable "vsphere_insecure" {
  type    = bool
  default = false
}

# vSphere Settings

variable "vsphere_datacenter" {
  type = string
}

variable "vsphere_cluster" {
  type = string
}

variable "vsphere_datastore" {
  type = string
}

variable "vsphere_folder" {
  type = string
}

variable "vsphere_network" {
  type = string
}

variable "vsphere_ext_network" {
  type = string
}

variable "vsphere_content_library" {
  type = string
}

#variable "vsphere_content_library_ovf" {
#  type = string
#}

variable "vsphere_content_library_tpl" {
  type = string
}

# Virtual Machine Settings

variable "vm_firmware" {
  type = string
}

variable "vm_efi_secure_boot_enabled" {
  type = bool
}

variable "vm_ipv4_address" {
  type = string
}

variable "vm_ipv4_netmask" {
  type = string
}

variable "vm_ipv4_gateway" {
  type = string
}

variable "vm_dns_suffix_list" {
  type = list(string)
}

variable "vm_dns_server_list" {
  type = list(string)
}

variable "vm_domain" {
  type = string
}

variable "vm_master_name" {
  type = string
}

variable "vm_master_cpus" {
  type = string
}

variable "vm_master_memory" {
  type = string
}

variable "vm_master_disk_size" {
  type = string
}

variable "vm_master_hostname" {
  type = string
}

variable "vm_master_count" {
  type = number
}

variable "vm_ingress_name" {
  type = string
}

variable "vm_ingress_cpus" {
  type = string
}

variable "vm_ingress_memory" {
  type = string
}

variable "vm_ingress_disk_size" {
  type = string
}

variable "vm_ingress_hostname" {
  type = string
}

variable "vm_ingress_count" {
  type = number
}

variable "vm_ingress_ip_list" {
  type = list(string)
}

variable "vm_ingress_ext_ip_list" {
  type = list(string)
}

variable "vm_node_name" {
  type = string
}

variable "vm_node_cpus" {
  type = string
}

variable "vm_node_memory" {
  type = string
}

variable "vm_node_disk_size" {
  type = string
}

variable "vm_node_disk1_size" {
  type = list(string)
}

variable "vm_node_hostname" {
  type = string
}

variable "vm_node_count" {
  type = number
}

variable "vm_node_ip_list" {
  type = list(string)
}

variable "vm_monitoring_name" {
  type = string
}

variable "vm_monitoring_cpus" {
  type = string
}

variable "vm_monitoring_memory" {
  type = string
}

variable "vm_monitoring_disk_size" {
  type = string
}

variable "vm_monitoring_disk1_size" {
  type = list(string)
}

variable "vm_monitoring_hostname" {
  type = string
}

variable "vm_monitoring_count" {
  type = number
}

variable "vm_monitoring_ip_list" {
  type = list(string)
}

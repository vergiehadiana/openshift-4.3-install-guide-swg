provider "vsphere" {
  user           = "adminstrator@vcenter.openshift.sw.gemilang"
  password       = "P@ssw0rd.1"
  vsphere_server = "192.168.100.10"

  # If you have a self-signed cert
  allow_unverified_ssl = true
}

data "vsphere_datacenter" "dc" {
  name = "swgdatacenter"
}

data "vsphere_compute_cluster" "cluster" {
  name          = "swgcluster"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_datastore" "mx1tb" {
  name          = "datastore2"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_virtual_machine" "rhel7" {
  name          = "rhel7"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_network" "network" {
  name          = "Openshift Network"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

variable "lb_mac" {
    description = "OCP 4 HAProxy MAC Address"
    type        = string
    default     = "00:50:56:b1:ef:ac"
}

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
  name          = "datastore1"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_virtual_machine" "RHCOS43" {
  name          = "RHCOS43"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_network" "network" {
  name          = "Openshift Network"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

variable "bootstrap_mac" {
    description = "OCP 4 Bootstrap MAC Address"
    type        = string
    default     = "00:50:56:b1:c7:ae"
}

variable "bootstrap_ignition_url" {
    #base64string
    default = "ewogICJpZ25pdGlvbiI6IHsKICAgICJjb25maWciOiB7CiAgICAgICJhcHBlbmQiOiBbCiAgICAgICAgewogICAgICAgICAgInNvdXJjZSI6ICJodHRwOi8vMTkyLjE2OC4xMDAuMTEwOjgwODAvaWduaXRpb24vYm9vdHN0cmFwLmlnbiIsCiAgICAgICAgICAidmVyaWZpY2F0aW9uIjoge30KICAgICAgICB9CiAgICAgIF0KICAgIH0sCiAgICAidGltZW91dHMiOiB7fSwKICAgICJ2ZXJzaW9uIjogIjIuMS4wIgogIH0sCiAgIm5ldHdvcmtkIjoge30sCiAgInBhc3N3ZCI6IHt9LAogICJzdG9yYWdlIjoge30sCiAgInN5c3RlbWQiOiB7fQp9Cg=="
}

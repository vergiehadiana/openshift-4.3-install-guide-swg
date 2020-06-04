resource "vsphere_virtual_machine" "lb" {
  name             = "ocp4.lb"
  folder           = "vergie/redhat/ocp4"
  resource_pool_id = "${data.vsphere_compute_cluster.cluster.resource_pool_id}"
  datastore_id     = "${data.vsphere_datastore.mx1tb.id}"
  count            = 1
  
  num_cpus = 2
  memory   = 1024
  guest_id = "${data.vsphere_virtual_machine.rhel7.guest_id}"

  network_interface {
    network_id = "${data.vsphere_network.network.id}"
    adapter_type = "${data.vsphere_virtual_machine.rhel7.network_interface_types[0]}"
    use_static_mac = true
    mac_address = "${var.lb_mac}"
  }
  clone {
    template_uuid = "${data.vsphere_virtual_machine.rhel7.id}"
    customize {
      linux_options{
        host_name = "ocp4-lb"
        domain = "openshift.sw.gemilang"
      }
      network_interface {}
    }
  }
  disk {
    label = "disk0"
    size  = 20
    thin_provisioned = "${data.vsphere_virtual_machine.rhel7.disks.0.thin_provisioned}"
  }
}

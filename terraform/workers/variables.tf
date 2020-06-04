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

variable "worker_macs" {
    description = "OCP 4 Worker MAC Address"
    type        = list(string)
    default     = ["00:50:56:b1:c7:ca", "00:50:56:b1:c7:cb"]#, "00:50:56:b1:c7:cc"]
}

variable "worker_ignition_url" {
    #base64string
    default = "eyJpZ25pdGlvbiI6eyJjb25maWciOnsiYXBwZW5kIjpbeyJzb3VyY2UiOiJodHRwczovL2FwaS1pbnQub2NwNC5vcGVuc2hpZnQuc3cuZ2VtaWxhbmc6MjI2MjMvY29uZmlnL3dvcmtlciIsInZlcmlmaWNhdGlvbiI6e319XX0sInNlY3VyaXR5Ijp7InRscyI6eyJjZXJ0aWZpY2F0ZUF1dGhvcml0aWVzIjpbeyJzb3VyY2UiOiJkYXRhOnRleHQvcGxhaW47Y2hhcnNldD11dGYtODtiYXNlNjQsTFMwdExTMUNSVWRKVGlCRFJWSlVTVVpKUTBGVVJTMHRMUzB0Q2sxSlNVUkZSRU5EUVdacFowRjNTVUpCWjBsSldHTktPRUZPZEZKbWMyOTNSRkZaU2t0dldrbG9kbU5PUVZGRlRFSlJRWGRLYWtWVFRVSkJSMEV4VlVVS1EzaE5TbUl6UW14aWJrNXZZVmRhTUUxU1FYZEVaMWxFVmxGUlJFVjNaSGxpTWprd1RGZE9hRTFDTkZoRVZFbDNUVVJaZDAxcVFUQk5SRWw2VFd4dldBcEVWRTEzVFVSVmVrMVVRVEJOUkVsNlRXeHZkMHBxUlZOTlFrRkhRVEZWUlVONFRVcGlNMEpzWW01T2IyRlhXakJOVWtGM1JHZFpSRlpSVVVSRmQyUjVDbUl5T1RCTVYwNW9UVWxKUWtscVFVNUNaMnR4YUd0cFJ6bDNNRUpCVVVWR1FVRlBRMEZST0VGTlNVbENRMmRMUTBGUlJVRnlUWEJxZEcxV1JVOU9SRFFLTlZkcVpHbHBhREpXYWpCbFluSjJlbGQzZFdsemNVdDRVR0ZNTjJwNVpFTTJVM2R1YWpWdWRqZGlVa1pGTUhwM1IwUjBhMWhxVkZsM1RqQk5UakJEZUFvMmJGcDBWREYyZWt4SmRucHpLME5rYjFSQlNGcE9kVmh0ZFc1M1pHbEROSFJxV1VNeWNFdDNSbVUzZEd0MWVsbGFUM1ZITWpZeVJYcDFkRTVXTkZGSkNuaHBiM0p0VkdWRll6bEZSMHBZVFVWVVVuRjRkblJWZEVkNmJGRjFTelJyV0VvcldXNVViVW8zU1hac2N5dE9lQ3RzVGtsYWExbGxiMVZwUWl0c2VETUtXazlFYlVOT1YxWnZaR0pGUVdGSVFqTlVUa3h3TUVGQmVVVXZXV3BqUkRKU04xTnNURTUzTHk4NVVqaHRRVmxWY1ZGTlVEZ3hWa0Z6TlV4d1UweEhUZ3BuWjBWdFNYRndjemxSYWtaR1kxSXlOakZvWTIxa1VXRnlRMGR0Y0U1Q2RVa3dlRU5RUTJOTk4xZHBlamtyVDIxbFJHRXdNbFZ1Wmxkc1VVSk9MMlJWQ2xVMlFWQjRUVXQyWTFGSlJFRlJRVUp2TUVsM1VVUkJUMEpuVGxaSVVUaENRV1k0UlVKQlRVTkJjVkYzUkhkWlJGWlNNRlJCVVVndlFrRlZkMEYzUlVJS0wzcEJaRUpuVGxaSVVUUkZSbWRSVlc5RmNuQTVURTFETmtGeFMxaHBhMFUxYmpKc2NtdFBRMmhtYjNkRVVWbEtTMjlhU1doMlkwNUJVVVZNUWxGQlJBcG5aMFZDUVVKdFZFbFBZalptUlVndmMwMDFSMFZyZDNwTmJrVlJhVXhWU0ROWmIzUnFhaXREZDNoUk1FZGFNMkZQVkZwQ1JrOWtjbVpRUVhCV016QnBDblF4WWxjd1F6WkdUMU5IZVM4d1VEZHBjRlF2Wmk5amVUZ3ZTMGR2YkRSMVVtWnJObEpDYURVelFVcHFibEpNTmtVd1VteG1XVGxqUkVkUGFtRktiMmdLVERCdFJYTlhZVWhXYmxNeUwyVjNPRXN2VUZsaksxZGFiMFZhTlU5QlNEaFlkR014VGtoRFpYUXdOMk50VTBGMmJVTk1NbTVOYTBvelNrcFpjVWxKU2dvM1drRjRNRXhtVmxWdGFHMTVUR0pXZEd4T1MyZElXR29yV0VJclZUTnlkR012TkdVeVdtb3ZWR1l5TW5kQ2NIaGxkakk0UjBOS1dGQTBRMjQ1VEVVckNpdDFUMUpFSzB3clMwMHZiVzVRU2l0UlluWmpXV0psV1ZOeWNWRTJURU5hVnpGR01IbEtkRTlVUjFkdlZHUlpZMjFPVkRWd1RXRk9aVmRZVHpKT1pGQUtTbXh1YW1GemVIZE9VV3RoU1V0TGFqYzRkVlpvZW05TmFUTnpQUW90TFMwdExVVk9SQ0JEUlZKVVNVWkpRMEZVUlMwdExTMHRDZz09IiwidmVyaWZpY2F0aW9uIjp7fX1dfX0sInRpbWVvdXRzIjp7fSwidmVyc2lvbiI6IjIuMi4wIn0sIm5ldHdvcmtkIjp7fSwicGFzc3dkIjp7fSwic3RvcmFnZSI6e30sInN5c3RlbWQiOnt9fQ=="
}

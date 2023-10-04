resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "google_compute_project_metadata" "metadata" {
  project = module.management_project.project_id

  metadata = {
    VmDnsSetting               = "GlobalDefault"
    enable-osconfig            = "TRUE"
    enable-guest-attributes    = "TRUE"
    osconfig-disabled-features = "guestpolicies"
    ssh-keys                   = "${var.ssh_user}:${tls_private_key.ssh_key.public_key_openssh}"
  }

  depends_on = [
    time_sleep.wait
  ]
}


locals {
  cmeks = [
    "cloud-logging",
    "cloud-sql",
    "cloud-storage",
    "compute-engine",
    "pub-sub",
    "secret-manager"
  ]
}

/*************************************************
  Create customer-managed encryption keys
*************************************************/

module "kms" {
  source = "../gcp-cloud-kms"

  project_id = google_project.management.project_id
  location   = var.region
  keyring    = "${var.keyring_prefix}-cmeks"
  keys       = local.cmeks

  key_rotation_period = "31536000s"

  depends_on = [
    time_sleep.wait
  ]
}

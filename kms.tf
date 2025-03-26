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
  source = "github.com/Coalfire-CF/terraform-google-kms?ref=v1.0.4"

  project_id = module.management_project[0].project_id
  location   = var.region
  keyring    = "${var.keyring_prefix}-cmeks"
  keys       = local.cmeks

  key_rotation_period = "31536000s"

  depends_on = [
    time_sleep.wait
  ]
}

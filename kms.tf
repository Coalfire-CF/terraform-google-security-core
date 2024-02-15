locals {
  cmeks = [
    "cloud_logging",
    "cloud_sql",
    "cloud_storage",
    "compute_engine",
    "pub_sub",
    "secret_manager"
  ]
}

/*************************************************
  Create customer-managed encryption keys
*************************************************/

module "kms" {
  source = "github.com/Coalfire-CF/terraform-google-kms"

  project_id = module.management_project.project_id
  location   = var.region
  keyring    = "${var.keyring_prefix}_cmeks"
  keys       = local.cmeks

  key_rotation_period = "31536000s"

  depends_on = [
    time_sleep.wait
  ]
}

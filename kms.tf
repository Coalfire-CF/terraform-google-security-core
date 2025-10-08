locals {
  default_cmeks = [
    "cloud-logging",
    "cloud-sql",
    "cloud-storage",
    "compute-engine",
    "pub-sub",
    "secret-manager"
  ]

  all_cmeks = concat(local.default_cmeks, var.additional_cmek_keys)
}

/*************************************************
  Create customer-managed encryption keys
*************************************************/

module "kms" {
  source = "git::https://github.com/Coalfire-CF/terraform-google-kms?ref=v1.0.4"

  project_id = module.management_project.project_id
  location   = var.region
  keyring    = "${var.keyring_prefix}-cmeks"
  keys       = local.all_cmeks

  key_rotation_period = "31536000s"

  depends_on = [
    time_sleep.wait
  ]
}

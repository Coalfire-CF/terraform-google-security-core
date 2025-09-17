/*************************************************
  Create cloud storage buckets
*************************************************/

module "gcs" {
  source = "git::https://github.com/Coalfire-CF/terraform-google-cloud-storage?ref=v1.0.4"

  project_id = module.management_project.project_id
  names = [
    "tfstate",
    "backups",
    "installs"
  ]
  prefix          = var.bucket_prefix
  set_admin_roles = true
  admins          = ["group:${var.group_org_admins}"]

  encryption_key_names = {
    tfstate  = module.kms.keys["cloud-storage"]
    backups  = module.kms.keys["cloud-storage"]
    installs = module.kms.keys["cloud-storage"]
  }

  versioning = {
    tfstate  = true
    backups  = true
    installs = true
  }

  location = var.region

  randomize_suffix = true

  depends_on = [google_kms_crypto_key_iam_member.gcs_account]
}

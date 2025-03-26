resource "google_organization_iam_member" "org_admins" {
  for_each = toset(var.org_admin_roles)

  org_id = var.org_id
  role   = each.value
  member = "group:${var.group_org_admins}"
}

/*************************************************
  Enable audit logging
*************************************************/

resource "google_organization_iam_audit_config" "org_config" {
  org_id  = var.org_id
  service = "allServices"

  dynamic "audit_log_config" {
    for_each = toset(["DATA_READ", "DATA_WRITE", "ADMIN_READ"])
    content {
      log_type = audit_log_config.key
    }
  }
}

/*************************************************
  Grant Cloud SQL svc acct access to CMEK
*************************************************/
resource "google_project_service_identity" "cloudsql_sa" {
  provider = google-beta

  project = module.management_project[0].project_id
  service = "sqladmin.googleapis.com"
}

resource "google_kms_crypto_key_iam_binding" "cloudsql_sa_kms_crypto" {
  crypto_key_id = module.kms.keys["cloud-sql"]
  role          = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
  members = [
    "serviceAccount:${google_project_service_identity.cloudsql_sa.email}",
  ]
}

resource "google_kms_crypto_key_iam_binding" "cloudsql_sa_viewer" {
  crypto_key_id = module.kms.keys["cloud-sql"]
  role          = "roles/cloudkms.viewer"
  members = [
    "serviceAccount:${google_project_service_identity.cloudsql_sa.email}",
  ]
}

/*************************************************
  Grant Cloud Storage svc acct access to CMEK
*************************************************/

data "google_storage_project_service_account" "gcs_account" {
  project = module.management_project[0].project_id
}

resource "google_kms_crypto_key_iam_member" "gcs_account" {
  crypto_key_id = module.kms.keys["cloud-storage"]
  role          = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
  member        = "serviceAccount:${data.google_storage_project_service_account.gcs_account.email_address}"
}

/*************************************************
  Grant Pub/Sub svc acct access to CMEK
*************************************************/

resource "google_kms_crypto_key_iam_member" "ps_account" {
  crypto_key_id = module.kms.keys["pub-sub"]
  role          = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
  member        = "serviceAccount:service-${module.management_project.project_number}@gcp-sa-pubsub.iam.gserviceaccount.com"

  depends_on = [
    time_sleep.wait
  ]
}

/*************************************************
  Grant Compute Engine svc acct access to CMEK
*************************************************/

resource "google_kms_crypto_key_iam_member" "ce_account" {
  crypto_key_id = module.kms.keys["compute-engine"]
  role          = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
  member        = "serviceAccount:service-${module.management_project.project_number}@compute-system.iam.gserviceaccount.com"

  depends_on = [
    time_sleep.wait
  ]
}

/*************************************************
  Grant Secret Manager svc acct access to CMEK
*************************************************/

resource "google_project_service_identity" "sm_sa" {
  provider = google-beta

  project = module.management_project[0].project_id
  service = "secretmanager.googleapis.com"
}

resource "google_kms_crypto_key_iam_member" "sm_account" {
  crypto_key_id = module.kms.keys["secret-manager"]
  role          = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
  member        = "serviceAccount:service-${module.management_project.project_number}@gcp-sa-secretmanager.iam.gserviceaccount.com"

  depends_on = [
    time_sleep.wait,
    google_project_service_identity.sm_sa
  ]
}

/*************************************************
  Grant org admins service account user for 
  compute engine svc acct
*************************************************/

data "google_compute_default_service_account" "default" {
  project = module.management_project[0].project_id
}

resource "google_service_account_iam_member" "ce_account_user" {
  service_account_id = data.google_compute_default_service_account.default.name
  role               = "roles/iam.serviceAccountUser"
  member             = "group:${var.group_org_admins}"

  depends_on = [
    time_sleep.wait
  ]
}

/*************************************************
  This is required for starting/stopping instances via instance scheduler
*************************************************/
resource "google_project_iam_custom_role" "start_stop_role" {
  project     = module.management_project[0].project_id
  role_id     = "rl_instancescheduler"
  title       = "Compute Engine Instance Scheduler"
  description = "Custom Role for Compute Engine Instance Schedules"
  permissions = ["compute.instances.start", "compute.instances.stop"]
}

resource "google_project_iam_member" "start_stop_role_member" {
  project = module.management_project[0].project_id
  role    = google_project_iam_custom_role.start_stop_role.id
  member  = "serviceAccount:service-${module.management_project.project_number}@compute-system.iam.gserviceaccount.com"

  depends_on = [
    time_sleep.wait
  ]
}

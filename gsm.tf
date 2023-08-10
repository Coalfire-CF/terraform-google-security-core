resource "google_secret_manager_secret" "gce_ssh_private_key" {
  project = google_project.management.project_id

  secret_id = "gce-ssh-private-key"

  replication {
    user_managed {
      replicas {
        location = var.region
        customer_managed_encryption {
          kms_key_name = module.kms.keys["secret-manager"]
        }
      }
    }
  }

  depends_on = [
    time_sleep.wait,
    google_kms_crypto_key_iam_member.sm_account
  ]

}

resource "google_secret_manager_secret_version" "gce_ssh_private_key" {
  secret = google_secret_manager_secret.gce_ssh_private_key.id

  secret_data = tls_private_key.ssh_key.private_key_pem
}

module "winbastion-administrator" {
  source = "github.com/Coalfire-CF/ACE-GCP-Secret-Manager"

  project_id = google_project.management.project_id
  region     = var.region

  secrets = [{
    id           = "winbastion-administrator"
    skip_version = true
  }]

  kms_key_name = module.kms.keys["secret-manager"]

  depends_on = [
    time_sleep.wait
  ]
}

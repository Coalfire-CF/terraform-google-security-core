resource "google_secret_manager_secret" "gce_ssh_private_key" {
  project = module.management_project.project_id

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

module "winbastion_administrator" {
  source = "git::https://github.com/Coalfire-CF/terraform-google-secret-manager?ref=v1.0.8"

  count = var.winbastion_administrator_secret ? 1 : 0

  project_id = module.management_project.project_id
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

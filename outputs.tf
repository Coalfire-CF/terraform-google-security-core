output "management_project" {
  value = module.management_project
}

output "networking_project" {
  value = module.networking_project
}

output "kms_key_ring_id" {
  value = module.kms.keyring
}

output "kms_key_ring_name" {
  value = module.kms.keyring_name
}

output "kms_keys" {
  value = module.kms.keys
}

output "group_org_admins" {
  value = var.group_org_admins
}

output "gce_ssh_private_key" {
  value = google_secret_manager_secret.gce_ssh_private_key.id
}

output "winbastion_administrator" {
  value = module.winbastion_administrator.names[0]
}

output "cs_buckets" {
  value = module.gcs.names
}

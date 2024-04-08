output "management_project" {
  value = module.management_project
}

output "networking_project" {
  value = module.networking_project
}

output "management_folder" {
  value = module.management_folder
}

output "networking_folder" {
  value = module.networking_folder
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

output "log_export_bucket" {
  value = try(module.destination[0].resource_name, null)
}

output "cs_buckets" {
  value = module.gcs.names
}

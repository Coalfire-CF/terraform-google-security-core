output "management_project" {
  value = try(module.management_project[0], null)
}

output "networking_project" {
  value = try(module.networking_project[0], null)
}

output "application_project" {
  value = try(module.application_project[0], null)
}

output "management_folder" {
  value = try(module.management_folder[0], null)
}

output "networking_folder" {
  value = try(module.networking_folder[0], null)
}

output "application_folder" {
  value = try(module.application_folder[0], null)
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

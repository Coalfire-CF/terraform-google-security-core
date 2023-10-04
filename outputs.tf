output "management_project" {
  value = module.management_project
}

output "networking_project" {
  value = module.networking_project
}

output "kms_keys" {
  value = module.kms.keys
}

output "group_org_admins" {
  value = var.group_org_admins
}

output "gce-ssh-private-key" {
  value = google_secret_manager_secret.gce_ssh_private_key.id
}

output "winbastion-administrator" {
  value = module.winbastion-administrator.secret_names[0]
}

output "cs_buckets" {
  value = module.gcs.names
}

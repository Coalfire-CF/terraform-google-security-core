output "management_project" {
  value = google_project.management
}

output "networking_project" {
  value = google_project.networking
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

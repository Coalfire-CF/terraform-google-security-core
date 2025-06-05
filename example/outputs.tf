output "group_org_admins" {
  value = module.bootstrap.group_org_admins
}

output "management_project_id" {
  value = module.bootstrap.management_project.project_id
}

output "gce_kms_key_id" {
  value = module.bootstrap.kms_keys["compute-engine"]
}

output "gsm_kms_key_id" {
  value = module.bootstrap.kms_keys["secret-manager"]
}

output "gcs_kms_key_id" {
  value = module.bootstrap.kms_keys["cloud-storage"]
}

output "sql_kms_key_id" {
  value = module.bootstrap.kms_keys["cloud-sql"]
}

output "gce_ssh_private_key" {
  value = module.bootstrap.gce_ssh_private_key
}
module "bootstrap" {
    source = "github.com/Coalfire-CF/terraform-google-security-core?ref=v1.0.17"

    org_id = var.org_id
    aw_folder_id = var.aw_folder_id
    billing_account = var.billing_account
    workspace_id = var.workspace_id
    group_org_admins = var.group_org_admins

    folder_prefix = var.folder_prefix
    bucket_prefix = var.bucket_prefix
    keyring_prefix = var.keyring_prefix
    project_prefix = var.project_prefix

    management_services = var.management_services
    networking_services = var.networking_services

    region = var.gcp_region
}
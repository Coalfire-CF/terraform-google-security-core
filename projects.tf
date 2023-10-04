/*************************************************
  Create projects and enable services
*************************************************/

# Management

resource "random_id" "suffix_management" {
  byte_length = 2
}

module "management_project" {
  source = "github.com/Coalfire-CF/terraform-gcp-project"

  name            = "${var.project_prefix}-management"
  project_id      = "${var.project_prefix}-management-${random_id.suffix_management.hex}"
  folder_id       = module.management_folder.folder_id
  billing_account = var.billing_account
  services        = var.management_services
}

# Networking

module "networking_project" {
  source = "github.com/Coalfire-CF/terraform-gcp-project"

  name            = "${var.project_prefix}-networking"
  project_id      = "${var.project_prefix}-networking-${random_id.suffix_networking.hex}"
  folder_id       = module.networking_folder.folder_id
  billing_account = var.billing_account
  services        = var.networking_services
}

resource "random_id" "suffix_networking" {
  byte_length = 2
}

resource "time_sleep" "wait" {
  create_duration = "120s"

  depends_on = [module.management_project, module.networking_project]
}

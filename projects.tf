/*************************************************
  Create projects and enable services
*************************************************/

# Management

module "management_project" {
  source = "github.com/Coalfire-CF/terraform-google-project?ref=v1.0.4"

  count = var.management_folder ? 1 : 0

  name            = "${var.project_prefix}-management"
  project_id      = "${var.project_prefix}-management"
  folder_id       = module.management_folder[0].folder_id
  billing_account = var.billing_account
  services        = var.management_services
}

# Networking

module "networking_project" {
  source = "github.com/Coalfire-CF/terraform-google-project?ref=v1.0.4"

  count = var.networking_folder ? 1 : 0

  name            = "${var.project_prefix}-networking"
  project_id      = "${var.project_prefix}-networking"
  folder_id       = module.networking_folder[0].folder_id
  billing_account = var.billing_account
  services        = var.networking_services
}

# Application

module "application_project" {
  source = "github.com/Coalfire-CF/terraform-google-project?ref=v1.0.4"

  count = var.application_folder ? 1 : 0

  name            = "${var.project_prefix}-application"
  project_id      = "${var.project_prefix}-application"
  folder_id       = module.application_folder[0].folder_id
  billing_account = var.billing_account
  services        = var.application_services
}

resource "time_sleep" "wait" {
  create_duration = "120s"

  depends_on = [module.management_project, module.networking_project, module.application_project]
}

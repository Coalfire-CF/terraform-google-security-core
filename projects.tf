/*************************************************
  Create projects and enable services
*************************************************/

# Management

resource "random_id" "suffix_management" {
  byte_length = 2
}

resource "google_project" "management" {
  name            = "${var.project_prefix}-management"
  project_id      = "${var.project_prefix}-management-${random_id.suffix_management.hex}"
  folder_id       = google_folder.management.folder_id
  billing_account = var.billing_account

  depends_on = [module.organization_policies_type_boolean]
}

resource "google_project_service" "management" {
  for_each = toset(var.management_services)

  project = google_project.management.id
  service = each.value
}

resource "google_resource_manager_lien" "management" {
  parent       = "projects/${google_project.management.number}"
  restrictions = ["resourcemanager.projects.delete"]
  origin       = "gcp-bootstrap"
  reason       = "This project is important"
}

# Networking

resource "random_id" "suffix_networking" {
  byte_length = 2
}

resource "google_project" "networking" {
  name            = "${var.project_prefix}-networking"
  project_id      = "${var.project_prefix}-networking-${random_id.suffix_networking.hex}"
  folder_id       = google_folder.networking.folder_id
  billing_account = var.billing_account

  depends_on = [module.organization_policies_type_boolean]
}

resource "google_project_service" "networking" {
  for_each = toset(var.networking_services)

  project = google_project.networking.id
  service = each.value
}

resource "google_resource_manager_lien" "networking" {
  parent       = "projects/${google_project.networking.number}"
  restrictions = ["resourcemanager.projects.delete"]
  origin       = "gcp-bootstrap"
  reason       = "This project is important"
}

resource "time_sleep" "wait" {
  create_duration = "120s"

  depends_on = [google_project_service.management, google_project_service.networking]
}

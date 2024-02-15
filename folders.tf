data "google_folder" "aw_folder" {
  folder = "folders/${var.aw_folder_id}"
}

/*************************************************
  Create folders
*************************************************/

module "management_folder" {
  source = "github.com/Coalfire-CF/terraform-google-folder"

  name   = "${var.folder_prefix}-management"
  parent = data.google_folder.aw_folder.name
}

module "networking_folder" {
  source = "github.com/Coalfire-CF/terraform-google-folder"

  name   = "${var.folder_prefix}-networking"
  parent = data.google_folder.aw_folder.name
}

module "application_folder" {
  source = "github.com/Coalfire-CF/terraform-google-folder"

  name   = "${var.folder_prefix}-application"
  parent = data.google_folder.aw_folder.name
}

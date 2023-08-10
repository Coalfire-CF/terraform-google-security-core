data "google_folder" "aw_folder" {
  folder = "folders/${var.aw_folder_id}"
}

/*************************************************
  Create folders
*************************************************/

resource "google_folder" "management" {
  display_name = "${var.folder_prefix}-management"
  parent       = data.google_folder.aw_folder.name
}

resource "google_folder" "networking" {
  display_name = "${var.folder_prefix}-networking"
  parent       = data.google_folder.aw_folder.name
}

resource "google_folder" "application" {
  display_name = "${var.folder_prefix}-application"
  parent       = data.google_folder.aw_folder.name
}

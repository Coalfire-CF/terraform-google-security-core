/*************************************************
  Send org logs to Pub/Sub
*************************************************/

resource "random_string" "suffix_sink" {
  length  = 4
  upper   = false
  special = false
}

module "log_export" {
  source = "git::https://github.com/Coalfire-CF/terraform-google-log-export?ref=v1.0.4"

  count = var.create_log_export ? 1 : 0

  destination_uri = module.destination[0].destination_uri
  filter          = var.log_filter

  log_sink_name          = "${var.sink_prefix}-org-${random_string.suffix_sink.result}"
  parent_resource_id     = var.org_id
  parent_resource_type   = "organization"
  include_children       = true
  unique_writer_identity = true

  depends_on = [
    time_sleep.wait
  ]
}

module "destination" {
  source = "git::https://github.com/Coalfire-CF/terraform-google-log-export//modules/storage?ref=v1.0.4"

  count = var.create_log_export ? 1 : 0

  project_id               = module.management_project.project_id
  storage_bucket_name      = "${var.bucket_prefix}-org-logs-${random_string.suffix_sink.result}"
  log_sink_writer_identity = module.log_export[0].writer_identity
  location                 = var.region
  kms_key_name             = module.kms.keys["cloud-storage"]

  lifecycle_rules = [{
    action = {
      type = "Delete"
    }
    condition = {
      age = 30
    }
  }]

  depends_on = [
    time_sleep.wait
  ]
}

/*************************************************
  Send org logs to Pub/Sub
*************************************************/

resource "random_string" "suffix_sink" {
  length  = 4
  upper   = false
  special = false
}

module "log_export" {
  source = "github.com/Coalfire-CF/terraform-google-log-export"

  destination_uri = module.destination.destination_uri
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
  source                   = "github.com/Coalfire-CF/terraform-google-log-export/modules/pubsub"
  project_id               = module.management_project.project_id
  topic_name               = "${var.topic_prefix}-org-logs-${random_string.suffix_sink.result}"
  log_sink_writer_identity = module.log_export.writer_identity
  create_subscriber        = true
  kms_key_name             = module.kms.keys["pub-sub"]

  depends_on = [
    time_sleep.wait,
    google_kms_crypto_key_iam_member.ps_account
  ]
}

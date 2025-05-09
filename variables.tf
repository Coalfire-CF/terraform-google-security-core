variable "org_id" {
  description = "GCP Organization ID"
  type        = string
}

variable "workspace_id" {
  description = "Workspace / Cloud Identity ID - get via `gcloud organizations list` from DIRECTORY_CUSTOMER_ID"
  type        = string
}

variable "aw_folder_id" {
  description = "Assured Workloads folder ID."
  type        = string
}

variable "billing_account" {
  description = "The ID of the billing account to associate projects with."
  type        = string
}

variable "group_org_admins" {
  description = "Google Group for GCP Organization Administrators."
  type        = string
}

variable "org_admin_roles" {
  description = "List of roles to assign to org admins."
  type        = list(string)
  default = [
    "roles/assuredworkloads.admin",
    "roles/billing.user",
    "roles/cloudkms.admin",
    "roles/cloudsql.admin",
    "roles/compute.admin",
    "roles/compute.instanceAdmin",
    "roles/compute.networkAdmin",
    "roles/compute.securityAdmin",
    "roles/compute.xpnAdmin",
    "roles/dns.admin",
    "roles/iam.securityAdmin",
    "roles/iam.serviceAccountAdmin",
    "roles/iam.serviceAccountUser",
    "roles/logging.admin",
    "roles/orgpolicy.policyAdmin",
    "roles/pubsub.admin",
    "roles/resourcemanager.folderAdmin",
    "roles/resourcemanager.organizationAdmin",
    "roles/secretmanager.admin",
    "roles/source.admin",
    "roles/storage.admin"
  ]
}

variable "boolean_type_organization_policies" {
  description = "List of boolean type org policies to apply."
  type        = list(string)
  default = [
    "compute.disableNonFIPSMachineTypes",
    "compute.skipDefaultNetworkCreation",
    "sql.restrictPublicIp",
    "storage.publicAccessPrevention"
  ]
}

variable "management_services" {
  description = "APIs & Services to enable for management project."
  type        = list(string)
  default = [
    "cloudkms.googleapis.com",
    "compute.googleapis.com",
    "logging.googleapis.com",
    "monitoring.googleapis.com",
    "pubsub.googleapis.com",
    "secretmanager.googleapis.com",
    "sourcerepo.googleapis.com",
    "privateca.googleapis.com",
    "iap.googleapis.com",
    "websecurityscanner.googleapis.com",
    "osconfig.googleapis.com",
    "certificatemanager.googleapis.com"
  ]
}

variable "networking_services" {
  description = "APIs & Services to enable for networking project."
  type        = list(string)
  default = [
    "compute.googleapis.com",
    "dns.googleapis.com",
    "logging.googleapis.com",
    "servicenetworking.googleapis.com",
    "secretmanager.googleapis.com",
    "pubsub.googleapis.com",
    "cloudkms.googleapis.com",
    "certificatemanager.googleapis.com"
  ]
}

variable "application_services" {
  description = "APIs & Services to enable for application project."
  type        = list(string)
  default = [
    "cloudkms.googleapis.com",
    "compute.googleapis.com",
    "logging.googleapis.com",
    "monitoring.googleapis.com",
    "pubsub.googleapis.com",
    "secretmanager.googleapis.com",
    "sourcerepo.googleapis.com",
    "privateca.googleapis.com",
    "iap.googleapis.com",
    "websecurityscanner.googleapis.com",
    "osconfig.googleapis.com",
    "certificatemanager.googleapis.com"
  ]
}

variable "region" {
  description = "The GCP region to create resources in."
  type        = string
}

variable "folder_prefix" {
  description = "Prefix for folders."
  type        = string
  default     = "fldr"
}

variable "project_prefix" {
  description = "Prefix for projects."
  type        = string
  default     = "prj"
}

variable "keyring_prefix" {
  description = "Prefix for key rings."
  type        = string
  default     = "kr"
}

variable "bucket_prefix" {
  description = "Prefix for buckets."
  type        = string
  default     = "bkt"
}

variable "sink_prefix" {
  description = "Prefix for sinks."
  type        = string
  default     = "sk"
}

variable "topic_prefix" {
  description = "Prefix for topics."
  type        = string
  default     = "ps"
}

variable "create_log_export" {
  description = "Whether or not to create log export"
  type        = bool
  default     = true
}

variable "log_filter" {
  description = "Log export filter."
  type        = string
  default     = <<EOF
    logName: /logs/cloudaudit.googleapis.com%2Factivity OR
    logName: /logs/cloudaudit.googleapis.com%2Fsystem_event OR
    logName: /logs/cloudaudit.googleapis.com%2Fdata_access OR
    logName: /logs/compute.googleapis.com%2Fvpc_flows OR
    logName: /logs/compute.googleapis.com%2Ffirewall OR
    logName: /logs/cloudaudit.googleapis.com%2Faccess_transparency
EOF
}

variable "ssh_user" {
  description = "Default user for SSH access"
  type        = string
  default     = "gce-user"
}

variable "networking_folder" {
  description = "Boolean value to determine if folder should be created."
  type        = bool
  default     = true
}

variable "application_folder" {
  description = "Boolean value to determine if folder should be created."
  type        = bool
  default     = true
}

variable "winbastion_administrator_secret" {
  description = "Boolean value to determine if WinBastion Administrator secret should be created."
  type        = bool
  default     = false
}

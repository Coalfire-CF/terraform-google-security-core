variable "org_id" {
  description = "GCP Organization ID"
  type = string
}

variable "aw_folder_id" {
  description = "Assured Workloads folder ID"
  type        = string
}

variable "billing_account" {
  description = "The ID of the billing account to associate projects with."
  type        = string
}

variable "workspace_id" {
  description = "Workspace ID #"
  type        = string
}

variable "group_org_admins" {
  description = "Google Group for GCP Organization Administrators"
  type        = string
}

variable "folder_prefix" {
  description = "Folder prefix value"
  type        = string
}

variable "bucket_prefix" {
  description = "bucket prefix value"
  type        = string
}

variable "keyring_prefix" {
  description = "keyring prefix value"
  type        = string
}

variable "project_prefix" {
  description = "project prefix value"
  type        = string
}
    
variable "management_services" {
  description = "APIs & Services to enable for management project."
  type        = list(string)
}

variable "networking_services" {
  description = "APIs & Services to enable for networking project."
  type        = list(string)
}

variable "gcp_region" {
  description = "The GCP region to create resources in."
  type        = string
}

variable "org_admin_roles" {
  description = "List of roles to assign to org admins."
  type        = list(string)
}
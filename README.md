![Coalfire](coalfire_logo.png)

# Google Cloud Security Core Terraform Module

## Description

The purpose of this module is to help bootstrap a GCP organization, creating all the required GCP resources to start deploying the FedRAMP reference architecture. The bootstrap is a dependency for all other deployment components. This module will create:

- Folders and Projects under the Assured Workloads folder
- Activate required APIs & Services in projects
- Create customer-managed encryption keys
- Create cloud storage buckets for Terraform state, installs and backups
- Create an organization log sink and destination
- Configure organization policies
- Enable audit logging

Coalfire has tested this module with Terraform version 1.5.0 and the Hashicorp Google provider versions 4.70 - 5.0.

### Usage

```
module "bootstrap" {
  source = "github.com/Coalfire-CF/terraform-google-security-core"

  # Must be set to prod to ensure org IAM permissions function properly; distinguishes from GCP sandbox env
  environment      = "prod" 

  org_id           = var.org_id
  aw_folder_id     = var.aw_folder_id
  billing_account  = var.billing_account
  group_org_admins = var.group_org_admins

  management_services = var.management_services
  networking_services = var.networking_services

  region = var.region
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | n/a |
| <a name="provider_google-beta"></a> [google-beta](#provider\_google-beta) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |
| <a name="provider_time"></a> [time](#provider\_time) | n/a |
| <a name="provider_tls"></a> [tls](#provider\_tls) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_application_folder"></a> [application\_folder](#module\_application\_folder) | git::https://github.com/Coalfire-CF/terraform-google-folder | v1.0.3 |
| <a name="module_application_project"></a> [application\_project](#module\_application\_project) | git::https://github.com/Coalfire-CF/terraform-google-project | v1.0.4 |
| <a name="module_destination"></a> [destination](#module\_destination) | git::https://github.com/Coalfire-CF/terraform-google-log-export//modules/storage | v1.0.4 |
| <a name="module_gcs"></a> [gcs](#module\_gcs) | git::https://github.com/Coalfire-CF/terraform-google-cloud-storage | v1.0.4 |
| <a name="module_kms"></a> [kms](#module\_kms) | git::https://github.com/Coalfire-CF/terraform-google-kms | v1.0.4 |
| <a name="module_log_export"></a> [log\_export](#module\_log\_export) | git::https://github.com/Coalfire-CF/terraform-google-log-export | v1.0.4 |
| <a name="module_management_folder"></a> [management\_folder](#module\_management\_folder) | git::https://github.com/Coalfire-CF/terraform-google-folder | v1.0.3 |
| <a name="module_management_project"></a> [management\_project](#module\_management\_project) | git::https://github.com/Coalfire-CF/terraform-google-project | v1.0.4 |
| <a name="module_networking_folder"></a> [networking\_folder](#module\_networking\_folder) | git::https://github.com/Coalfire-CF/terraform-google-folder | v1.0.3 |
| <a name="module_networking_project"></a> [networking\_project](#module\_networking\_project) | git::https://github.com/Coalfire-CF/terraform-google-project | v1.0.4 |
| <a name="module_organization_policies_domain_restricted_sharing"></a> [organization\_policies\_domain\_restricted\_sharing](#module\_organization\_policies\_domain\_restricted\_sharing) | git::https://github.com/Coalfire-CF/terraform-google-org-policy | v1.0.3 |
| <a name="module_organization_policies_tls_restriction"></a> [organization\_policies\_tls\_restriction](#module\_organization\_policies\_tls\_restriction) | git::https://github.com/Coalfire-CF/terraform-google-org-policy | v1.0.3 |
| <a name="module_organization_policies_type_boolean"></a> [organization\_policies\_type\_boolean](#module\_organization\_policies\_type\_boolean) | git::https://github.com/Coalfire-CF/terraform-google-org-policy | v1.0.3 |
| <a name="module_winbastion_administrator"></a> [winbastion\_administrator](#module\_winbastion\_administrator) | git::https://github.com/Coalfire-CF/terraform-google-secret-manager | v1.0.6 |

## Resources

| Name | Type |
|------|------|
| [google-beta_google_project_service_identity.cloudsql_sa](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_project_service_identity) | resource |
| [google-beta_google_project_service_identity.sm_sa](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_project_service_identity) | resource |
| [google_compute_project_metadata.metadata](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_project_metadata) | resource |
| [google_kms_crypto_key_iam_binding.cloudsql_sa_kms_crypto](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/kms_crypto_key_iam_binding) | resource |
| [google_kms_crypto_key_iam_binding.cloudsql_sa_viewer](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/kms_crypto_key_iam_binding) | resource |
| [google_kms_crypto_key_iam_member.ce_account](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/kms_crypto_key_iam_member) | resource |
| [google_kms_crypto_key_iam_member.gcs_account](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/kms_crypto_key_iam_member) | resource |
| [google_kms_crypto_key_iam_member.ps_account](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/kms_crypto_key_iam_member) | resource |
| [google_kms_crypto_key_iam_member.sm_account](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/kms_crypto_key_iam_member) | resource |
| [google_organization_iam_audit_config.org_config](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/organization_iam_audit_config) | resource |
| [google_organization_iam_member.org_admins](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/organization_iam_member) | resource |
| [google_project_iam_custom_role.start_stop_role](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_custom_role) | resource |
| [google_project_iam_member.start_stop_role_member](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_secret_manager_secret.gce_ssh_private_key](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/secret_manager_secret) | resource |
| [google_secret_manager_secret_version.gce_ssh_private_key](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/secret_manager_secret_version) | resource |
| [google_service_account_iam_member.ce_account_user](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account_iam_member) | resource |
| [random_string.suffix_sink](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [time_sleep.wait](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |
| [tls_private_key.ssh_key](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |
| [google_compute_default_service_account.default](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/compute_default_service_account) | data source |
| [google_folder.aw_folder](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/folder) | data source |
| [google_storage_project_service_account.gcs_account](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/storage_project_service_account) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_cmek_keys"></a> [additional\_cmek\_keys](#input\_additional\_cmek\_keys) | Additional customer-managed encryption keys to create beyond the default set | `list(string)` | `[]` | no |
| <a name="input_application_folder"></a> [application\_folder](#input\_application\_folder) | Boolean value to determine if folder should be created. | `bool` | `true` | no |
| <a name="input_application_services"></a> [application\_services](#input\_application\_services) | APIs & Services to enable for application project. | `list(string)` | <pre>[<br/>  "cloudkms.googleapis.com",<br/>  "compute.googleapis.com",<br/>  "logging.googleapis.com",<br/>  "monitoring.googleapis.com",<br/>  "pubsub.googleapis.com",<br/>  "secretmanager.googleapis.com",<br/>  "privateca.googleapis.com",<br/>  "iap.googleapis.com",<br/>  "websecurityscanner.googleapis.com",<br/>  "osconfig.googleapis.com",<br/>  "certificatemanager.googleapis.com"<br/>]</pre> | no |
| <a name="input_aw_folder_id"></a> [aw\_folder\_id](#input\_aw\_folder\_id) | Assured Workloads folder ID. | `string` | n/a | yes |
| <a name="input_billing_account"></a> [billing\_account](#input\_billing\_account) | The ID of the billing account to associate projects with. | `string` | n/a | yes |
| <a name="input_boolean_type_organization_policies"></a> [boolean\_type\_organization\_policies](#input\_boolean\_type\_organization\_policies) | List of boolean type org policies to apply. | `list(string)` | <pre>[<br/>  "compute.disableNonFIPSMachineTypes",<br/>  "compute.skipDefaultNetworkCreation",<br/>  "sql.restrictPublicIp",<br/>  "storage.publicAccessPrevention"<br/>]</pre> | no |
| <a name="input_bucket_prefix"></a> [bucket\_prefix](#input\_bucket\_prefix) | Prefix for buckets. | `string` | `"bkt"` | no |
| <a name="input_create_log_export"></a> [create\_log\_export](#input\_create\_log\_export) | Whether or not to create log export | `bool` | `true` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment type - 'sandbox' for internal testing, 'prod' for production deployments | `string` | `"sandbox"` | no |
| <a name="input_folder_prefix"></a> [folder\_prefix](#input\_folder\_prefix) | Prefix for folders. | `string` | `"fldr"` | no |
| <a name="input_group_org_admins"></a> [group\_org\_admins](#input\_group\_org\_admins) | Google Group for GCP Organization Administrators. | `string` | n/a | yes |
| <a name="input_keyring_prefix"></a> [keyring\_prefix](#input\_keyring\_prefix) | Prefix for key rings. | `string` | `"kr"` | no |
| <a name="input_log_filter"></a> [log\_filter](#input\_log\_filter) | Log export filter. | `string` | `"    logName: /logs/cloudaudit.googleapis.com%2Factivity OR\n    logName: /logs/cloudaudit.googleapis.com%2Fsystem_event OR\n    logName: /logs/cloudaudit.googleapis.com%2Fdata_access OR\n    logName: /logs/compute.googleapis.com%2Fvpc_flows OR\n    logName: /logs/compute.googleapis.com%2Ffirewall OR\n    logName: /logs/cloudaudit.googleapis.com%2Faccess_transparency\n"` | no |
| <a name="input_management_services"></a> [management\_services](#input\_management\_services) | APIs & Services to enable for management project. | `list(string)` | <pre>[<br/>  "cloudkms.googleapis.com",<br/>  "compute.googleapis.com",<br/>  "logging.googleapis.com",<br/>  "monitoring.googleapis.com",<br/>  "pubsub.googleapis.com",<br/>  "secretmanager.googleapis.com",<br/>  "privateca.googleapis.com",<br/>  "iap.googleapis.com",<br/>  "websecurityscanner.googleapis.com",<br/>  "osconfig.googleapis.com",<br/>  "certificatemanager.googleapis.com"<br/>]</pre> | no |
| <a name="input_networking_folder"></a> [networking\_folder](#input\_networking\_folder) | Boolean value to determine if folder should be created. | `bool` | `true` | no |
| <a name="input_networking_services"></a> [networking\_services](#input\_networking\_services) | APIs & Services to enable for networking project. | `list(string)` | <pre>[<br/>  "compute.googleapis.com",<br/>  "dns.googleapis.com",<br/>  "logging.googleapis.com",<br/>  "servicenetworking.googleapis.com",<br/>  "secretmanager.googleapis.com",<br/>  "pubsub.googleapis.com",<br/>  "cloudkms.googleapis.com",<br/>  "certificatemanager.googleapis.com"<br/>]</pre> | no |
| <a name="input_org_admin_roles"></a> [org\_admin\_roles](#input\_org\_admin\_roles) | List of roles to assign to org admins. | `list(string)` | <pre>[<br/>  "roles/assuredworkloads.admin",<br/>  "roles/billing.user",<br/>  "roles/cloudkms.admin",<br/>  "roles/cloudsql.admin",<br/>  "roles/compute.admin",<br/>  "roles/compute.instanceAdmin",<br/>  "roles/compute.networkAdmin",<br/>  "roles/compute.securityAdmin",<br/>  "roles/compute.xpnAdmin",<br/>  "roles/dns.admin",<br/>  "roles/iam.securityAdmin",<br/>  "roles/iam.serviceAccountAdmin",<br/>  "roles/iam.serviceAccountUser",<br/>  "roles/logging.admin",<br/>  "roles/orgpolicy.policyAdmin",<br/>  "roles/pubsub.admin",<br/>  "roles/resourcemanager.folderAdmin",<br/>  "roles/resourcemanager.organizationAdmin",<br/>  "roles/secretmanager.admin",<br/>  "roles/source.admin",<br/>  "roles/storage.admin"<br/>]</pre> | no |
| <a name="input_org_id"></a> [org\_id](#input\_org\_id) | GCP Organization ID | `string` | n/a | yes |
| <a name="input_project_prefix"></a> [project\_prefix](#input\_project\_prefix) | Prefix for projects. | `string` | `"prj"` | no |
| <a name="input_region"></a> [region](#input\_region) | The GCP region to create resources in. | `string` | n/a | yes |
| <a name="input_sink_prefix"></a> [sink\_prefix](#input\_sink\_prefix) | Prefix for sinks. | `string` | `"sk"` | no |
| <a name="input_ssh_user"></a> [ssh\_user](#input\_ssh\_user) | Default user for SSH access | `string` | `"gce-user"` | no |
| <a name="input_topic_prefix"></a> [topic\_prefix](#input\_topic\_prefix) | Prefix for topics. | `string` | `"ps"` | no |
| <a name="input_winbastion_administrator_secret"></a> [winbastion\_administrator\_secret](#input\_winbastion\_administrator\_secret) | Boolean value to determine if WinBastion Administrator secret should be created. | `bool` | `false` | no |
| <a name="input_workspace_id"></a> [workspace\_id](#input\_workspace\_id) | Workspace / Cloud Identity ID - get via `gcloud organizations list` from DIRECTORY\_CUSTOMER\_ID | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_application_folder"></a> [application\_folder](#output\_application\_folder) | n/a |
| <a name="output_application_project"></a> [application\_project](#output\_application\_project) | n/a |
| <a name="output_cs_buckets"></a> [cs\_buckets](#output\_cs\_buckets) | n/a |
| <a name="output_gce_ssh_private_key"></a> [gce\_ssh\_private\_key](#output\_gce\_ssh\_private\_key) | n/a |
| <a name="output_group_org_admins"></a> [group\_org\_admins](#output\_group\_org\_admins) | n/a |
| <a name="output_kms_key_ring_id"></a> [kms\_key\_ring\_id](#output\_kms\_key\_ring\_id) | n/a |
| <a name="output_kms_key_ring_name"></a> [kms\_key\_ring\_name](#output\_kms\_key\_ring\_name) | n/a |
| <a name="output_kms_keys"></a> [kms\_keys](#output\_kms\_keys) | n/a |
| <a name="output_log_export_bucket"></a> [log\_export\_bucket](#output\_log\_export\_bucket) | n/a |
| <a name="output_management_folder"></a> [management\_folder](#output\_management\_folder) | n/a |
| <a name="output_management_project"></a> [management\_project](#output\_management\_project) | n/a |
| <a name="output_networking_folder"></a> [networking\_folder](#output\_networking\_folder) | n/a |
| <a name="output_networking_project"></a> [networking\_project](#output\_networking\_project) | n/a |
<!-- END_TF_DOCS -->

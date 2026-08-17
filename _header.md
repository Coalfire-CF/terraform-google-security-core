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

## Dependencies

- Google Cloud organization
- Assured Workloads folder

### Usage

```
module "bootstrap" {
  source = "github.com/Coalfire-CF/terraform-google-security-core"

  # Must be set to prod to ensure org IAM permissions function properly; distinguishes from GCP sandbox env
  environment      = "prod" 

  org_id           = var.org_id
  aw_folder_id     = var.aw_folder_id
  billing_account  = var.billing_account
  workspace_id     = var.workspace_id
  group_org_admins = var.group_org_admins

  management_services = var.management_services
  networking_services = var.networking_services

  region = var.gcp_region
}
```


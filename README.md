# Google Cloud Bootstrap

The purpose of this module is to help bootstrap a GCP organization, creating all the required GCP resources to start deploying the FedRAMP reference architecture. The bootstrap is a dependency for all other deployment components. This module will create:

- Folders and Projects under the Assured Workloads folder
- Activate required APIs & Services in projects
- Create customer-managed encryption keys
- Create cloud storage buckets for Terraform state, installs and backups
- Create an organization log sink and destination
- Configure organization policies
- Enable audit logging
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.70, < 5.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = ">= 4.70, < 5.0"
    }
  }
  # Comment this out on initial deployment. Once tf apply is successful, 
  # uncomment and re-run terraform init -reconfigure. Type 'yes' when prompted
  # to copy local state to new remote backend
  backend "gcs" {
    bucket = "<STATE BUCKET NAME>"
    prefix = "terraform/state/security-core"
  }
}
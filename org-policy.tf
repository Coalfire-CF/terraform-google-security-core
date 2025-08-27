/*************************************************
  Enable boolean type organization policies
*************************************************/

module "organization_policies_type_boolean" {
  source = "github.com/Coalfire-CF/terraform-google-org-policy?ref=v1.0.3"

  for_each = toset(var.boolean_type_organization_policies)

  organization_id = var.org_id
  policy_for      = "organization"
  policy_type     = "boolean"
  enforce         = "true"
  constraint      = "constraints/${each.value}"
}

module "organization_policies_domain_restricted_sharing" {
  source = "github.com/Coalfire-CF/terraform-google-org-policy?ref=v1.0.3"

  organization_id = var.org_id
  policy_for      = "organization"
  policy_type     = "list"
  enforce         = "true"
  constraint      = "constraints/iam.allowedPolicyMemberDomains"
  allow = [
    "principalSet://iam.googleapis.com/organizations/${var.org_id}",
    var.workspace_id
  ]
  allow_list_length = 2
}

module "organization_policies_tls_restriction" {
  source = "github.com/Coalfire-CF/terraform-google-org-policy?ref=v1.0.3"

  organization_id = var.org_id
  policy_for      = "organization"
  policy_type     = "list"
  enforce         = "true"
  constraint      = "constraints/gcp.restrictTLSVersion"

  deny = [
    "TLS_VERSION_1",
    "TLS_VERSION_1_1"
  ]
  
  deny_list_length = 2
}
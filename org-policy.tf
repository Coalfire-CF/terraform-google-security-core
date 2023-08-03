/*************************************************
  Enable boolean type organization policies
*************************************************/

module "organization_policies_type_boolean" {
  source = "github.com/Coalfire-CF/ACE-GCP-Org-Policy"

  for_each = toset(var.boolean_type_organization_policies)

  organization_id = var.org_id
  policy_for      = "organization"
  policy_type     = "boolean"
  enforce         = "true"
  constraint      = "constraints/${each.value}"
}

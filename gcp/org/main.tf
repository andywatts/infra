provider "google" {
  region = local.region
}

resource "google_project" "projects" {
  for_each = local.projects

  project_id      = each.value.project_id
  name            = each.value.project_name
  billing_account = local.billing_account_id
}


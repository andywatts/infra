resource "google_project_service" "services" {
  for_each = toset(local.services)

  project            = local.project_id
  service            = each.value
  disable_on_destroy = false
}

resource "google_project_iam_member" "members" {
  for_each = local.iam_members

  project = local.project_id
  role    = each.value.role
  member  = each.key
}


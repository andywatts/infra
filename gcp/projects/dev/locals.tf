locals {
  billing_account_id = "011037-08A7BB-7E1039"
  project_hash       = substr(md5(local.billing_account_id), 0, 6)
  project_id         = "development-${local.project_hash}"
  region             = "us-west2"

  services = [
    "compute.googleapis.com",
    "storage.googleapis.com",
    "container.googleapis.com"
  ]

  iam_members = {
  }
}

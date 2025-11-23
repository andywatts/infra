locals {
  billing_account_id = "011037-08A7BB-7E1039"
  region             = "us-central1"
  
  project_hash = substr(md5(local.billing_account_id), 0, 6)

  projects = {
    dev = {
      project_id   = "development-${local.project_hash}"
      project_name = "Development"
    }
  }
}


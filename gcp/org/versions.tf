terraform {
  required_version = "1.5.7"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
  backend "gcs" {
    bucket = "awatts-terraform-state-gcp"
    prefix = "org"
  }
}


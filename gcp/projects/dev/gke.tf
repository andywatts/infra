resource "google_container_cluster" "primary" {
  name     = "dev-cluster"
  location = "${local.region}-a"

  initial_node_count       = 1
  remove_default_node_pool = true

  deletion_protection = false
}

resource "google_container_node_pool" "primary" {
  name       = "primary-pool"
  location   = google_container_cluster.primary.location
  cluster    = google_container_cluster.primary.name
  node_count = 1

  node_config {
    machine_type = "e2-small"
    disk_size_gb = 20

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}


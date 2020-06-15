provider "google" {
  project = var.provider_project_name
  region  = var.provider_region
}

terraform {
  backend "gcs" {
    bucket = "tf-state-otus"
    prefix = "kubernetes/monitoring"
  }
}

resource "google_container_cluster" "gke-cluster" {
  name               = var.cluster_name
  network            = "default"
  initial_node_count = var.node_count
  location           = var.cluster_zone
  description        = var.cluster_description
}

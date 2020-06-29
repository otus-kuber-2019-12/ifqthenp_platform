provider "google" {
  project = var.provider_project_name
  region  = var.provider_region
}

data "google_container_engine_versions" "euwest2a" {
  location       = var.cluster_zone
  version_prefix = "1.16."
}

resource "google_container_cluster" "gke-cluster" {
  name               = var.cluster_name
  network            = "default"
  initial_node_count = var.node_count
  location           = var.cluster_zone
  description        = var.cluster_description
  node_version       = data.google_container_engine_versions.euwest2a.latest_node_version
  min_master_version = data.google_container_engine_versions.euwest2a.latest_master_version
  logging_service    = var.logging_service
  monitoring_service = var.monitoring_service
}

output "latest_node_version" {
  value = data.google_container_engine_versions.euwest2a.latest_node_version
}

output "latest_master_version" {
  value = data.google_container_engine_versions.euwest2a.latest_master_version
}

output "default_cluster_version" {
  value = data.google_container_engine_versions.euwest2a.default_cluster_version
}

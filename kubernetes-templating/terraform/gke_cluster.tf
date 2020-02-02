resource "google_container_cluster" "gke-cluster" {
  name               = "otus-hw-kubernetes-templating"
  network            = "default"
  initial_node_count = 1
  location           = "europe-west2-a"
  description        = "Kubernetes Templating HW"
}

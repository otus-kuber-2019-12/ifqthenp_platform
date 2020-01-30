provider "google" {
  project = "otus-hw"
  region  = "europe-west2a"
}

resource "google_storage_bucket" "tf_state_bucket" {
  name     = "tf-state-otus"
  location = "EUROPE-WEST2"
}


output "storage-bucket-url" {
  value = google_storage_bucket.tf_state_bucket.url
}

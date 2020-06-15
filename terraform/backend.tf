terraform {
  backend "gcs" {
    bucket      = "tf-state-otus"
    prefix      = "kubernetes/templating"
  }
}

variable "backend_prefix" {
  description = "Prefix for remote terraform state bucket"
  type        = string
}

variable "cluster_description" {
  description = "GKE cluster short description"
  type        = string
}

variable "cluster_name" {
  description = "Name of GKE cluster"
  type        = string
}

variable "node_count" {
  description = "GKE cluster initial node count"
  type        = number
  default     = 1
}

variable "cluster_zone" {
  description = "GKE cluster zone"
  type        = string
  default     = "europe-west2-a"
}

variable "provider_project_name" {
  description = "GCP project name"
  type        = string
  default     = "otus-hw"
}

variable "provider_region" {
  description = "GCP region"
  type        = string
  default     = "europe-west2"
}

variable "logging_service" {
  description = "Default logging service provided by GKE"
  type        = string
  default     = "none"
}

variable "monitoring_service" {
  description = "Default monitoring service provided by GKE"
  type        = string
  default     = "none"
}

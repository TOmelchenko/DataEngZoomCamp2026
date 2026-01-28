terraform {
  required_version = ">= 1.0"
  backend "local" {}  # Can change from "local" to "gcs" (for google) or "s3" (for aws), if you would like to preserve your tf-state online
  required_providers {
    google = {
      source  = "hashicorp/google"
    }
  }
}

#provider "google" {
#  project = var.project
#  region = var.region
#  credentials = file(var.credentials) 
#}

#this part for temporary token using
provider "google" {
   project = var.project
   region  = var.region
   zone    = var.zone
 }


# This data source gets a temporary token for the service account
 data "google_service_account_access_token" "default" {
   provider               = google
   target_service_account = "dezc2026-user@dataengineeringzoomcamp2026.iam.gserviceaccount.com"
   scopes                 = ["https://www.googleapis.com/auth/cloud-platform"]
   lifetime               = "3600s"
 }
 
 # This second provider block uses that temporary token and does the real work
 provider "google" {
   alias        = "impersonated"
   access_token = data.google_service_account_access_token.default.access_token
   project      = var.project
   region       = var.region
   zone         = var.zone
 } 
 
# Data Lake Bucket
# Ref: https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket
resource "google_storage_bucket" "data-lake-bucket" {
  name          = var.bucket_name
  location      = var.region
  # Optional, but recommended settings:
  storage_class = var.storage_class
  uniform_bucket_level_access = true

  versioning {
    enabled     = true
  }

  lifecycle_rule {
    action {
      type = "Delete"
    }
    condition {
      age = 30  // days
    }
  }

  force_destroy = true
}

# DWH
# Ref: https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/bigquery_dataset
resource "google_bigquery_dataset" "dataset" {
  dataset_id = var.BQ_DATASET
  project    = var.project
} 

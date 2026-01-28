locals {
  data_lake_bucket = "dezc2026_data_lake"
}


#variable "credentials" {
#  description = "My Credentials"
#  default     = "/Users/tetianaomelchenko/opt/gcp/dataengineeringzoomcamp2026-2f06863ada10.json"
#  #ex: if you have a directory where this file is called keys with your service account json file
#  #saved there as my-creds.json you could use default = "./keys/my-creds.json"
#}

variable "project" {
  description = "dataengineeringzoomcamp2026"
}
variable "region" {
  description = "Region for GCP resources. Choose as per your location: https://cloud.google.com/about/locations"
  default = "europe-west1"
  type = string
}

variable "zone" {
  default = "europe-west1-b"
}

variable "bucket_name" {
  description = "The name of the GCS bucket. Must be globally unique."
  default = "dezc2026_data_bucket"
}

variable "storage_class" {
  description = "Storage class type for your bucket. Check official docs for more info."
  default = "STANDARD"
}

variable "BQ_DATASET" {
  description = "BigQuery Dataset that raw data (from GCS) will be written to"
  type = string
  default = "trips_data_all"
}

variable "TABLE_NAME" {
  description = "BigQuery Table"
  type = string
  default = "ny_trips"
} 

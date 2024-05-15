module "gke" {
  source                     = "terraform-google-modules/kubernetes-engine/google"
  depends_on = [module.vpc]
  project_id = "gke-costing"
  name = "gke1"
  region = "us-central1"
  zones = ["us-central1-a", "us-central1-b", "us-central1-f"]
  network = module.vpc.network.network_name
  subnetwork = module.vpc.subnets_names[0]
  #ip_range_pods = module.vpc.subnets_names[0]
    ip_range_pods      = ""
  ip_range_services  = ""
}
module "vpc" {
    source  = "terraform-google-modules/network/google"
    project_id = "gke-costing"
    network_name = "vpc-01"
    subnets = [
        {
            subnet_name           = "us-central1-01"
            subnet_ip             = "10.10.10.0/24"
            subnet_region         = "us-central1"
        }]


}
resource "google_bigquery_dataset" "default" {
  project                      = "gke-costing"
  dataset_id                      = "gke_cost1"
  default_partition_expiration_ms = 2592000000  # 30 days
  default_table_expiration_ms     = 31536000000 # 365 days
  description                     = "dataset description"
  location                        = "US"
  max_time_travel_hours           = 96 # 4 days

  labels = {
    billing_group = "gke-costing",
  }
}

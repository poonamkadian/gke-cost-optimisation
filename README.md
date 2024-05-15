# gke-cost-optimisation
GKE cost optimisation with Resources usage meterices.

### 1. Creating GKE cluster
Prerequisites: 
   * VPC 
   * Network (If not created then it will use default subnet)

Note: in this kubernetes cluster creation GKE and VPC modules are used.

download this repo and login into GCP cloud 


gcloud auth application-default login

It will redirect to login into browser and authenticate the user. After login credentials token will be copied to local machine. Using this command user do not need service account key for terraform creation. 

Intially provide the cluster details into terraform main.tf
* Project_id
* gke name
* VPC name
* cluster location (region,zones)
* Network
* Subnetwork
* subnet_ip 

Once the GKE cluster is ready Login into GKE cluster
Click on Kubernetes Clusters in gcp console -> click on connect
gke-connect.png

copy gke connect command -> enter this command into local terminal

copy-login-command.png


or 

Login into GCP cloud -> Enable cloud shell 
cloudshell.png

Click on Clusters -> click on connect -> copy gke connect command-> enter this command into GCP cloud shell
image connect-cloudshell.png

### 2. Enable GKE Cost Allocation 

Prerequisites: 
Bigquery Dataset

Using Gcloud CLI

gcloud container clusters update gke1 enable-resource-consumption-metering --zone us-central1-a  --resource-usage-bigquery-dataset gke-costing

Using GUI
Create dataset in Big query (already provisioned in terraform)
Click on GKE cluster
scroll down to features 
click on edit -> enable cost allocation -> select Big query dataset 
click on edit -> GKE Usage Metrices -> select Big query dataset 

image enable-features

Follow Below Link for understanding the usage metrices
[Understand the Cloud Billing data tables in BigQuery](https://cloud.google.com/billing/docs/how-to/export-data-bigquery-tables)

## 3. Enabled	GKE usage metering 
Prerequisites: 
Bigquery Dataset

 Gcloud CLI

gcloud container clusters update gke1 --resource-usage-bigquery-dataset gke-cost

Using GUI 

Click on GKE cluster
scroll down to features 
click on edit -> GKE Usage Metrices -> select Big query dataset 
 select Enable network data transfer metering
 select Enable resource consumption metering

Once it is enabled it will create 2 tables in BigQuery dataset.

Follow Below Link for understanding the usage metrices
[Understanding cluster resource usage](https://cloud.google.com/kubernetes-engine/docs/how-to/cluster-usage-metering?&_gl=1*hhh71d*_ga*MTYxNDY4NjkxOS4xNzE1MzQyNDQz*_ga_WH2QY8WWF5*MTcxNTc1MjAyMy45LjEuMTcxNTc1MzcyMS4wLjAuMA..&_ga=2.98374303.-1614686919.1715342443#view_in_data-studio)


## 4. Export GCP Billing
Search Export billing in Google cloud search bar
Select Details usage billing -> Select Project Name -> Dataset Name

Once it is enabled it will create a billing-export tables in BigQuery dataset.

image big-query-dataset.png


## 5. Explore looker studio
Once every data is published into the all tables, select Looker Studio for data Exploration.

click on Export-> Exlplore data with Looker Studio

[Example queries for Cloud Billing data export](https://cloud.google.com/billing/docs/how-to/bq-examples#sum-costs-per-invoice)

## Few Best Practices Link 

#### Best practices for running cost-optimized Kubernetes applications on GKE 
https://cloud.google.com/architecture/best-practices-for-running-cost-effective-kubernetes-applications-on-gke














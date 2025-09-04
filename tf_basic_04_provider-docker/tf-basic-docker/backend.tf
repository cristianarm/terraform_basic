# state snapshots are stored (local, aws S3, GCS, among others)
# Where and how operations are performed (local or remote)

terraform {
 backend "local" {
   path = "./tfstate/terraform.tfstate"
 }
}

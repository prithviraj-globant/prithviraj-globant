provider "aws" {
  region     = "us-east-1"
  access_key = "AKIARN2TV5OHDXB26Y63"
  secret_key = "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"
}

terraform {
  backend "s3" {
    bucket = "terraform-backend-autodesk-test"
    key    = "audesk/auto.tfstate"
    region = "us-east-1"
	access_key = "AKIARN2TV5OHDXB26Y63"
  secret_key = "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"
  }
}
module "VPC"{
	source = "/home//prithviraj/Downloads/Modules/VPC"
availability_zone1="${var.availability_zone1}"
availability_zone2="${var.availability_zone2}"
main_vpc_cidr="${var.main_vpc_cidr}"
}

module "security" {
source = "/home//prithviraj/Downloads/Modules/security"
vpc-id="${module.VPC.vpc-id}"
}

module "ASG" {
source = "/home//prithviraj/Downloads/Modules/ASG"
instance-sg = "${module.security.instance-sg}" 
loadbalancer-sg = "${module.security.loadbalancer-sg}" 
sub1 = "${module.VPC.sub1}" 
sub2 = "${module.VPC.sub2}" 
pub1 = "${module.VPC.pub1}" 
pub2 = "${module.VPC.pub2}" 
key_name = "${var.key_name}" 
AMIS = "${var.AMIS}"
}

module "bucket" {
  source = "/home/prithviraj/Downloads/Modules/bucket"
}
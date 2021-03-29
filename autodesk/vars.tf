variable "AMIS" {
  default = "ami-047a51fa27710816e"
}
variable "key_name" {
  description = "Enter Your Key name "
  default     = "test_terraform"
}
variable "availability_zone1" {
  description = "Avaialbility Zones"
  default     = "us-east-1a"
}

variable "availability_zone2" {
  description = "Avaialbility Zones"
  default     = "us-east-1b"
}
variable "main_vpc_cidr" {
  description = "CIDR of the VPC"
  default     = "10.0.0.0/16"
}

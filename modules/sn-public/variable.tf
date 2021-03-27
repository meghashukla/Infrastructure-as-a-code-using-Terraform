## Expected values from the caller
variable "vpc_id" {}

variable "vpc_region" {}
variable "subnet_name" {}
variable "subnet_cidr" {
    type = list
}
variable "subnet_az" {
   type = list
}

#data "aws_availability_zones" "subnet_az" {
 # state = "available"
#}

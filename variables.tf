variable "vpc_region" {
  description = "AWS region"
  default     = "us-east-1"
}

variable "vpc_name" {
  default     = "mastervpc"
}

variable "vpc_cidr_block" {
  default     = "10.0.0.0/16"
}

variable "subnet_public" {
 description = "Public subnet for VPC"
 default     = "publicsubnet"
}

variable "subnet_public_cidr" {
  description = "CIDR for public subnet"
  default     = ["10.0.1.0/24","10.0.2.0/24"]
}

variable "subnet_public_az" {
 description = "Availability zone for public subnet"
default     = ["us-east-1a","us-east-1b"]
}

 variable "subnet_private" {
 description = "Private subnet for demo Network"
 default     = "privatesubnet"
}

variable "subnet_private_cidr" {
  description = "CIDR for internal subnet"
  default     = "10.0.128.0/24"
}

variable "subnet_private_az" {
description = "Region for private subnet"
default     = "us-east-1b"
}

variable "sg_internal" {
  description = "Security group for private traffic"
  default     = "internal"
}

variable "sg_public" {
  description = "Security group for public traffic"
  default     = "public"
}

variable "amiid" {
default = "ami-096fda3c22c1c990a"
}
variable "instance_type" {
default = "t2.micro" 
}

variable "instance_name" {
  default = "Masterwebserver"
}

variable "rootvolumesize" {
  default = 20
}
variable "rootvolumetype" {
  default = "gp2"
}

variable "alb_name" {
  default = "masterloadbalancer"
  }
variable "ebsvolumesize" {
  default = [50]
}
variable "numberofvolumes" {
  default = 1
}

variable "key_pair_name" {
  default = "mykeypair"
}

variable "max_size"{
  default = "2"
}

variable "min_size" {
  default = "1"
}

variable desired_capacity{
  default = "1"
}
variable "display_name" {
default = "Admin Notifications"
}
variable "email_address" {
  default = "msmeghashukla@gmail.com"
}
variable "protocol" {
  default = "email"
}
variable "max_5xx_errors" {
  default = 200
}

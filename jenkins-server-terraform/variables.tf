variable "bucket_name" {
    type = string
    description = "S3 bucket name for backend" 
}

variable "vpc_cidr" {
  type = string
  description = "VPC-CIDR for vpc"
}

variable "vpc_name" {
  type = string
  description = "vpc name "
}

variable "cidr_public_subnet" {
  type = list(string)
  description = "public sunet cidr"
}

variable "cidr_private_subnet" {
    type = list(string)
    description = "private subnate cidr"
  
}

variable "vpc_az" {
  type = list(string)
  description = "Availability zone"
}
variable "vpc_sg_allowports" {
  type = list(number)
  description = "security group allow ports"
}

variable "public_key" {
  type = string
  description = "public key for connect ec2"
}

variable "ec2_ami_id" {
    type = string
    description = "emiid for create ec2 instance"
  
}

variable "instance_type" {
    type = string
    description = "instance type for ec2 instance"
  
}
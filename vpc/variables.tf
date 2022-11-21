variable "cidr_block" {
    description = "(optional) give the range which you want."
    type = string # ex:- "10.0.1.0/16"
}

variable "subnet_cidr_block" {
  description = "(optional) give the subnet cidr black"
  type = string # ex:- "10.0.1.0/24"
}

variable "availability_zone" {
    description = "(optional) availability zone which you want"
    type = string # ex:- "ap-south-1a"
}

variable "vpc" {
  description = "(Optional) Boolean if the EIP is in a VPC or not."
  type = Boolean
  default = true
}

variable "route_cidr_block" {
    description = "(optional) give the routes "
    type = string
    default = "0.0.0.0/0"
}

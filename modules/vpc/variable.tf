variable "name" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "az_list" {
  type = list(any)
}
variable "private_subnets_list" {
  type = list(any)
}

variable "public_subnets_list" {
  type = list(any)
}

variable "NAT" {
  type = bool
}

variable "env" {
  type = string
}
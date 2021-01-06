variable "vpc_id" {
  type = string
}

variable "internet_gateway_id" {
  type = string
}

variable "public_subnet_ids" {
  type = list(any)
}

variable "private_subnet_ids" {
  type = list(any)
}

variable "nat_ids" {
  type = list(any)
}

variable "vpc_peering_connection_id" {
  type = string
}

variable "peering_vpc_cidr" {
  type = string
}

variable "public_subnet_cidr_list" {
  type = list(any)
}

variable "private_subnet_cidr_list" {
  type = list(any)
}

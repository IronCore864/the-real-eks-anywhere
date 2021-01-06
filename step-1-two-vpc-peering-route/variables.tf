# main vpc
variable "main_vpc_name" {
  type    = string
  default = "vpc1"
}

variable "main_vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "main_vpc_public_subnets_az_cidr_map" {
  type = map(any)
  default = {
    "eu-central-1a" = "10.0.1.0/24"
    "eu-central-1b" = "10.0.2.0/24"
  }
}

variable "main_vpc_private_subnets_az_cidr_map" {
  type = map(any)
  default = {
    "eu-central-1a" = "10.0.11.0/24"
    "eu-central-1b" = "10.0.12.0/24"
  }
}

# 2nd vpc, not used yet
variable "second_vpc_name" {
  type    = string
  default = "vpc2"
}

variable "second_vpc_cidr" {
  type    = string
  default = "10.1.0.0/16"
}

variable "second_vpc_public_subnets_az_cidr_map" {
  type = map(any)
  default = {
    "eu-central-1a" = "10.1.1.0/24"
    "eu-central-1b" = "10.1.2.0/24"
  }
}

variable "second_vpc_private_subnets_az_cidr_map" {
  type = map(any)
  default = {
    "eu-central-1a" = "10.1.11.0/24"
    "eu-central-1b" = "10.1.12.0/24"
  }
}

terraform {
  required_version = ">= 0.14.2"
  required_providers {
    aws = {
      version = ">= 3.22"
      source  = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = "eu-central-1"
  ignore_tags {
    key_prefixes = ["kubernetes.io/"]
  }
}

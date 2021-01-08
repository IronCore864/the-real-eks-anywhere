terraform {
  required_version = ">= 0.14.2"

  required_providers {
    aws = {
      version = ">= 3.22"
      source  = "hashicorp/aws"
    }
  }

  backend "s3" {
    bucket         = "tf-state-391996659322"
    key            = "tf-eks-anywhere/step1/terraform.tfstate"
    region         = "eu-central-1"
    encrypt        = true
    dynamodb_table = "tf_state_lock_391996659322"
  }
}

provider "aws" {
  region = "eu-central-1"
  ignore_tags {
    key_prefixes = ["kubernetes.io/"]
  }
}

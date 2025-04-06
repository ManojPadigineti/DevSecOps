terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region     = "us-east-1"
  access_key = "AKIA6B2JWEYQMFRBVMJ7"
  secret_key = "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"
}
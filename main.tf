terraform {
  required_version = "~>1.16.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
  backend "s3" {
    bucket         = "terramast-1709"
    key            = "terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terra-table"
  }
}
#configure the aws provider region
provider "aws" {
  region = var.regmum
  alias  = "Mumbai"
}

provider "aws" {
  region = var.reghyd
  alias  = "Hyderabad"
}

provider "aws" {
  region = var.regsing
  alias  = "Singapore"
}


# create a vpc in Hyderabad region
resource "aws_vpc" "hyderabad_vpc" {
  provider             = aws.Hyderabad
  cidr_block           = var.cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "VPC-Hydra01"
  }
}
# create a vpc in Singapore region
resource "aws_vpc" "singapore_vpc" {
  provider   = aws.Singapore
  cidr_block = var.cidr

  tags = {
    Name = "VPC-Singa01"
  }
}

resource "aws_vpc" "mumbai_vpc" {
  provider   = aws.Mumbai
  cidr_block = var.cidr

  tags = {
    Name = "VPC-Mumbai01"
  }
}

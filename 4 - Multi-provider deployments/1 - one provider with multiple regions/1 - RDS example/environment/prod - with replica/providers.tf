terraform {
    required_providers {
        aws = {
        source  = "hashicorp/aws"
        version = "5.0"
        }
    }
}

provider "aws" {
    alias = "primary"
    region = "us-east-1" # N. Virginia
}

provider "aws" {
    alias = "secondary"
    region = "us-east-2" # Ohio
}
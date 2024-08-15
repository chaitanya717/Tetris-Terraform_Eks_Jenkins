terraform {
  backend "s3" {
    bucket         = "eks-my-game-terraState-bucket"
    region         = "eu-west-1"
    key            = "gamecicdTerraform/eks-tf/terraform.tfstate"
    encrypt        = true
  }
  required_version = ">=0.13.0"
  required_providers {
    aws = {
      version = ">= 2.7.0"
      source  = "hashicorp/aws"
    }
  }
}
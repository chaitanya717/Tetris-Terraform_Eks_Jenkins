terraform {
  backend "s3" {
    bucket = "my-game-terrastate-bucket"
    key = "./terraform.tfstate"
    region = "eu-west-1"
  }
}
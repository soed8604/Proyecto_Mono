terraform {
  backend "s3" {
    bucket = "mono-cicd-terraform-eks"
    key    = "eks/terraform.tfstate"
    region = "us-east-1"
  }
}
terraform {
  backend "s3" {
    bucket = "mono-cicd-terraform-eks"
    key    = "jenkins/terraform.tfstate"
    region = "us-east-1"
  }
}
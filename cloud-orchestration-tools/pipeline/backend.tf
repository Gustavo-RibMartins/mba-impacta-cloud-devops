terraform {
  backend "s3" {
    bucket = "gustavo-ribmartins-vorx-terraform"
    key    = "jenkins-network.tfstate"
    region = "us-east-1"
  }
}
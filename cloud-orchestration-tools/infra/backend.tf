terraform {
    backend "s3" {
        bucket = "gustavo-ribmartins-vorx-terraform"
        key = "vorx-network.tfstate"
        region = "us-east-1"
    }
}
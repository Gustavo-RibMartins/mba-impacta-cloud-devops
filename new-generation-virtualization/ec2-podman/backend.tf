terraform {
    backend "s3" {
        bucket = "terraform-backend-aprendizado"
        key = "cloud-orchestration-tools:new-generation-virtualization:ec2-podman.tfstate"
        region = "us-east-1"
    }
}
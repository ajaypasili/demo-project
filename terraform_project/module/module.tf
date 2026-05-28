provider "aws" {
    region = "ap-south-1"
  
}

module "compute" {
    source = "/home/ec2-user/terraform_project/workspace"
  
}

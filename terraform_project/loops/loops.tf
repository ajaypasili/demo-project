terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~>5.0"
    }
  }
}

provider "aws" {
    region = "ap-south-1"
  
}

resource "aws_instance" "web" {
    ami = "ami-034a8236c75419857"
    instance_type = each.value
    for_each = var.instance_type
    key_name = "mymainkeypair"

    tags = {
      Name = "myserver-${each.key}"
    }
}

terraform {
  
  backend "s3" {
    bucket = "nbalphabucket"
    key = "backend/terraform.tfstate"
    region = "ap-south-1"
    
  }
  
  required_providers {
    aws = {
        source = "hashicorp/aws"
    }
  }
}


provider "aws" {

    region = "ap-south-1"

}

resource "aws_instance" "server1" {
    instance_type = "t3.micro"
    ami = "ami-034a8236c75419857"
    key_name = "mymainkeypair"
    availability_zone = "ap-south-1a"

    root_block_device {
      volume_type = "gp3"
      volume_size = 17
      encrypted = true
    }

    tags = {
      Name = "1st server"
    }

  
}


output "myeip" {
    value = aws_instance.server1.public_ip
  
}

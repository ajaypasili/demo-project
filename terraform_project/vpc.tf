terraform {
  required_providers {
    aws = {
        resource = "hashicorp/aws"
    }
  }
}

provider "aws" {
    region = "ap-south-1"  
}

# create VPC
resource "aws_vpc" "myvpc" {
    cidr_block = "10.0.0.0/16"

    tags = {
      Name = "ajay_vpc"
    }
}

#creating subnets

resource "aws_subnet" "subnet1" {
    vpc_id = aws_vpc.myvpc.id
    cidr_block = "10.0.0.0/24"
    availability_zone = "ap-south-1a"

    tags = {
      Name = "ajay_subnet1"
    }
}

resource "aws_subnet" "subnet2" {
    vpc_id = aws_vpc.myvpc.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "ap-south-1a"

    tags = {
      Name = "ajay_subnet2"
    } 
  
}

#creating internet gateway
resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.myvpc.id
  
}

#route tables
resource "aws_route_table" "RT" {
    vpc_id = aws_vpc.myvpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }
  
}

resource "aws_route_table_association" "rts1" {
    route_table_id = aws_route_table.RT
    subnet_id = aws_subnet.subnet1.id
  
}
resource "aws_route_table_association" "rts2" {
    route_table_id = aws_route_table.RT.id
    subnet_id = aws_subnet.subnet2.id  
}

#creating security group
resource "aws_security_group" "asg" {
    vpc_id = aws_vpc.myvpc.id
    name = "ajay"

    ingress {
        description = "allow ssh"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        description = "ssh"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
      Name = "ajay-sg"
    }
  
}


# S3 bucket
resource "aws_s3_bucket" "my_bucket" {
    bucket = "nbalphabucket1"
  
}

resource "aws_instance" "web" {
    instance_type = "t3.micro"
    ami = "ami-034a8236c75419857"
    availability_zone = "ap-south-1a"
    key_name = "mymainkeypair"
    vpc_security_group_ids = aws_security_group.asg.id
    subnet_id = aws_subnet.subnet1.id

    root_block_device {
      volume_type = "gp3"
      volume_size = 11
      encrypted = true

    }
    tags = {
      Name = "ajay server"
    }
  
}

output "myip" {
    value = aws_instance.web.public_ip
}

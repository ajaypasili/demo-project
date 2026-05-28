provider "aws" {

    region = "ap-south-1"
  
}

resource "aws_instance" "examp" {
    instance_type = local.cpu
    ami = "ami-034a8236c75419857"
    key_name = "mymainkeypair"
    availability_zone = "ap-south-1a"

    tags = {
      Name = local.owner
    }
  
}

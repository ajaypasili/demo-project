provider "aws" {
    region = "ap-south-1"
  
}

resource "aws_instance" "web" {
    instance_type = "t3.micro"
    ami = "ami-034a8236c75419857"
    key_name = "mymainkeypair"
    count = 3

    tags = {
      Name = "servers-${count.index +1}"
    }
  
}

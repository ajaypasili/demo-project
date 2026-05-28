provider "aws" {
    region = var.region
}

resource "aws_instance" "web" {
    instance_type = var.instance_type
    ami = "ami-034a8236c75419857"
    key_name = "mymainkeypair"
    availability_zone = "ap-south-1c"

    root_block_device {
        volume_type = "gp3"
        volume_size = 20
        encrypted = true
    }

    tags = {
      Name = "chandu_server"
    }

}

resource "aws_eip" "my_eip" {
    instance = aws_instance.web.id
}

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}
 
resource "aws_instance" "ajay" {

  ami               = "ami-09ed39e30153c3bf9"
  instance_type     = "t3.micro"
  key_name          = "mymainkeypair"
  availability_zone = "ap-south-1a"

  provisioner "local-exec" {

    command = <<EOT
sleep 60
ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i '${self.public_ip},' playbook.yml -u ec2-user --private-key /home/ec2-user/harika/sai.key
EOT
  }

  tags = {
    Name = "Ajay-server"
  }
}
output "myeip" {
  value = aws_instance.ajay.public_ip   
}

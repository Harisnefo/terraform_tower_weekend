terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.62.0"
    }
  }
}

provider "aws" {
  # Configuration options
  profile = "netfox"
}

resource "aws_security_group" "provisioner_SG" {
  name        = "provisioner_SG"
  description = "Allow HTTP inbound traffic"

  ingress {
    description = "HTTP Access"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH Access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH Access"
    from_port   = 9100
    to_port     = 9100
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH Access"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "jenkins_SG2"
  }
}



# # EC2 resource with instance volume
resource "aws_instance" "Test_provisioner" {
  ami                    = "ami-04823729c75214919"
  instance_type          = "t2.medium"
  vpc_security_group_ids = [aws_security_group.provisioner_SG.id]
  key_name               = "netfox_key"
  tags = {
    "Name" = "Jenkins_EC2"
  }

  ebs_block_device {
    device_name           = "/dev/sdh"
    volume_size           = 20
    volume_type           = "gp2"
    delete_on_termination = true
  }


  provisioner "file" {
    source      = "./jenkins.sh"
    destination = "/home/ec2-user/jenkins.sh"
    connection {
      host        = self.public_ip
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("~/Downloads/netfox_key.pem")
    }
  }

  provisioner "remote-exec" {
    #script = "./jenkins.sh"
    inline = [
      "sudo chmod +x /home/ec2-user/jenkins.sh",
      "sudo /home/ec2-user/jenkins.sh"
    ]

    connection {
      host        = self.public_ip
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("~/Downloads/netfox_key.pem")

    }
  }

}

resource "aws_instance" "ec2_pycharm" {
   ami = data.aws_ami.linuxAMI.id
   instance_type = var.instance_type
  subnet_id = var.subnet_id
  tags = {
    Name = "Hello_world"
    Environment = "env"
  }
}
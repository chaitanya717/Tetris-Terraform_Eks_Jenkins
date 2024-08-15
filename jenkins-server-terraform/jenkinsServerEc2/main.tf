variable "ami_id" {}
variable "instance_type" {}
variable "tag_name" {}
variable "public_key" {}
variable "subnet_id" {}
variable "sg_for_jenkins" {
    type = list(string)
}
variable "enable_public_ip_address" {}
variable "user_data_install_jenkins" {}
output "jenkinsSererid" {
    value = aws_instance.jenkins_ec2_instance_ip_flaskapi.id
}

resource "aws_key_pair" "jenkinsinstance_key" {
  key_name = "jen_key"
  public_key = var.public_key
}
resource "aws_instance" "jenkins_ec2_instance_ip_flaskapi" {
  ami = var.ami_id
  instance_type = var.instance_type

  tags = {
    Name = var.tag_name
  }
  key_name = "jen_key"
  subnet_id = var.subnet_id
  vpc_security_group_ids = var.sg_for_jenkins
  associate_public_ip_address = var.enable_public_ip_address

  user_data = var.user_data_install_jenkins

  metadata_options {
    http_endpoint = "enabled"
    http_tokens = "required"
  }
}

output "kubectlServerid" {
    value = aws_instance.jenkins_ec2_instance_ip_flaskapi.id
}

resource "aws_key_pair" "instance_key" {
  key_name = "kubectl_key"
  public_key = var.public_key
}
resource "aws_instance" "kubectl_ec2_instance" {
  ami = var.ami_id
  instance_type = var.instance_type
  tags = {
    Name = var.tag_name
  }
  key_name = "kubectl_key"
  subnet_id = data.aws_subnet.public-subnet.id
  vpc_security_group_ids = [data.aws_security_group.sg_http_ssh.id]
  associate_public_ip_address = true
  user_data = var.user_data_install_kubectl
  
  metadata_options {
    http_endpoint = "enabled"
    http_tokens = "required"
  }
}

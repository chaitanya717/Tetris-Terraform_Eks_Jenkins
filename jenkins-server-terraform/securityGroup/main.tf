variable "ec2_sg_name" {}
variable "vpc_id" {}
variable "ec2_jenkins_sg_name" {}
variable "vpc_sg_allowports" {
    type = list(number)
}
output "output_id_sg_http_ssh" {
  value = aws_security_group.sg_http_ssh.id
}

output "output_id_sg_jenkinsport_group" {
  value = aws_security_group.sg_jenkinsPort_group.id
}

resource "aws_security_group" "sg_http_ssh" {
  name = var.ec2_sg_name
  description = "Enable the Port 22(SSH) & Port 80(http)"
  vpc_id = var.vpc_id

  ingress = [
    for port in var.vpc_sg_allowports : {
      cidr_blocks = ["0.0.0.0/0"]
    from_port = port
    to_port = port
    protocol = "tcp"
    }
  ]

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  tags = {
    Name = "SecurityGrp to allow SSH(22) and HTTP(80)"
  }
}

resource "aws_security_group" "sg_jenkinsPort_group" {
  name = "${var.ec2_sg_name}-jenkins"
  vpc_id = var.vpc_id
   
   ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
   }
   ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 9000
    to_port = 9000
    protocol = "tcp"
   }

   tags = {
     Name = "SecurityGrps  to allow SSH(22) and HTTP(80)"
   }
}
variable "vpc_cidr" {}
variable "vpc_name" {}
variable "cidr_public_subnet" {}
variable "cidr_private_subnet" {}
variable "vpc_az" {}

output "flask_api_vpcid" {
  value = aws_vpc.flask-api-terraform-cicd.id
}

 output "dev_proj_public_subnet" {
     value = aws_subnet.publicsubnet-dev-proj.*.id
 }
 output "public_subnet-cidr_block" {
     value = aws_subnet.privatesubnet-dev-proj.*.cidr_block
 }

resource "aws_vpc" "flask-api-terraform-cicd" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "publicsubnet-dev-proj" {
  count = length(var.cidr_public_subnet)
  vpc_id = aws_vpc.flask-api-terraform-cicd.id
  cidr_block = element(var.cidr_public_subnet, count.index)
  availability_zone = element(var.vpc_az, count.index)
  map_public_ip_on_launch = true
  tags = {
    Name = "public-subnet-${count.index + 1}-dev-proj"
  }
}
resource "aws_subnet" "privatesubnet-dev-proj" {
  count = length(var.cidr_private_subnet)
  vpc_id = aws_vpc.flask-api-terraform-cicd.id
  cidr_block = element(var.cidr_private_subnet, count.index)
  availability_zone = element(var.vpc_az, count.index)

  tags = {
    Name = "private-subnet-${count.index + 1}-dev-proj"
  }
}

resource "aws_internet_gateway" "ingetway-publicsubnet-dev-proj" {
  vpc_id = aws_vpc.flask-api-terraform-cicd.id
  tags = {
    Name = "igw-dev-proj"
  }
}

# public subnet route table
resource "aws_route_table" "publicsubnet-dev-proj-routetable" {
    vpc_id = aws_vpc.flask-api-terraform-cicd.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.ingetway-publicsubnet-dev-proj.id
    }

    tags = {
      Name = "route-table-devProj"
    }
  
}

# public subnet route table
resource "aws_route_table" "publicsubnet-dev717-proj-routetable" {
    vpc_id = aws_vpc.flask-api-terraform-cicd.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.ingetway-publicsubnet-dev-proj.id
    }

    tags = {
      Name = "route-table-devProj"
    }
  
}

# private subnate route table
resource "aws_route_table" "privatesubnet-dev717-routetable" {
    vpc_id = aws_vpc.flask-api-terraform-cicd.id
   
   tags = {
     Name = "privatesubnet-routetable"
   }
  
}

# public subnet route table association
resource "aws_route_table_association" "devProjpublicsubnet" {
    count = length(aws_subnet.publicsubnet-dev-proj)
    subnet_id = aws_subnet.publicsubnet-dev-proj[count.index].id
    route_table_id = aws_route_table.publicsubnet-dev717-proj-routetable.id     
}

# private route table association
resource "aws_route_table_association" "privatesubnet-routetable-association" {
    count = length(aws_subnet.privatesubnet-dev-proj)
    subnet_id = aws_subnet.privatesubnet-dev-proj[count.index].id
    route_table_id = aws_route_table.privatesubnet-dev717-routetable.id
}
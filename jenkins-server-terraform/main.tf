module "networking" {
    source = "./networking"
    vpc_az = var.vpc_az
    vpc_cidr = var.vpc_cidr
    vpc_name = var.vpc_name
    cidr_private_subnet = var.cidr_private_subnet
    cidr_public_subnet = var.cidr_public_subnet
}

module "securitygroup" {
  source = "./securityGroup"
 ec2_sg_name = "sSg-ssh-http"
 vpc_id = module.networking.flask_api_vpcid
 ec2_jenkins_sg_name = "Allow port 8080 for jenkins"
 vpc_sg_allowports = var.vpc_sg_allowports
  
}

module "jenkinsServer" {
    source = "./jenkinsServerEc2"
    ami_id = var.ec2_ami_id
    instance_type = var.instance_type
    tag_name = "jenkins:server"
    public_key = var.public_key
    subnet_id = tolist(module.networking.dev_proj_public_subnet)[0]
    sg_for_jenkins = [module.securitygroup.output_id_sg_jenkinsport_group, module.securitygroup.output_id_sg_http_ssh]
    enable_public_ip_address = true
      user_data_install_jenkins = templatefile("./jenkinsInstall.sh",{})
}

# module "targetgroup" {
#     source = "./lbtargetgroup"
#     lb_target_group_name = ""
#     lb_target_group_port = ""
#     lb_target_group_protocol = ""
#     vpc_id = module.networking.flask_api_vpcid
#     ec2_instance_id = module.jenkinsServer.jenkinsSererid  
# }

# RESOURCE: VPC and Networking via module
module "network" {
  source = "./modules/network"
}

# RESOURCE: EC2
data "template_file" "user_data" {
    template = "${file("./scripts/user_data.sh")}"
}

resource "aws_instance" "instance-1a" {
    ami                    = "ami-00a929b66ed6e0de6"
    instance_type          = "t2.micro"
    subnet_id              = module.network.subnet_az1a_id
    vpc_security_group_ids = [module.network.security_group_id]
    user_data_base64       = "${base64encode(data.template_file.user_data.rendered)}"
    key_name               = "vockey"
}

resource "aws_instance" "instance-1b" {
    ami                    = "ami-00a929b66ed6e0de6"
    instance_type          = "t2.micro"
    subnet_id              = module.network.subnet_az1b_id
    vpc_security_group_ids = [module.network.security_group_id]
    user_data_base64       = "${base64encode(data.template_file.user_data.rendered)}"
    key_name               = "vockey"
}

# RESOURCE: ALB via module
module "alb" {
  source            = "./modules/alb"
  vpc_id            = module.network.vpc_id
  subnet_az1a_id    = module.network.subnet_az1a_id
  subnet_az1b_id    = module.network.subnet_az1b_id
  security_group_id = module.network.security_group_id
  instance_1a_id    = aws_instance.instance-1a.id
  instance_1b_id    = aws_instance.instance-1b.id
}


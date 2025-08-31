###########################
# VPC
###########################

module "vpc" {
  source     = "./modules/vpc"
  cidr_block = "10.0.0.0/16"
  name       = "${var.name}-vpc"
}

###########################
# Public Network
###########################

# Internet Gateway
module "internet_gateway" {
  source = "./modules/internet_gateway"
  vpc_id = module.vpc.vpc_id
  name   = "${var.name}-igw"
}

# Subnets
module "public_subnet_a" {
  source                  = "./modules/subnet"
  vpc_id                  = module.vpc.vpc_id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "eu-central-1a"
  map_public_ip_on_launch = true
  name                    = "${var.name}-public-subnet-a"
}

module "public_subnet_b" {
  source                  = "./modules/subnet"
  vpc_id                  = module.vpc.vpc_id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "eu-central-1b"
  map_public_ip_on_launch = true
  name                    = "${var.name}-public-subnet-b"
}

# Route Tables
module "public_route_table" {
  source = "./modules/route_table"
  vpc_id = module.vpc.vpc_id
  name   = "${var.name}-public-route-table"
}

# Routes
module "public_route" {
  source                 = "./modules/route"
  route_table_id         = module.public_route_table.route_table_id
  gateway_id             = module.internet_gateway.ig_id
  destination_cidr_block = "0.0.0.0/0"
}


# Route Table Associations
module "public_route_table_assoc_a" {
  source         = "./modules/route_table_association"
  subnet_id      = module.public_subnet_a.subnet_id
  route_table_id = module.public_route_table.route_table_id
}

module "public_route_table_assoc_b" {
  source         = "./modules/route_table_association"
  subnet_id      = module.public_subnet_b.subnet_id
  route_table_id = module.public_route_table.route_table_id
}

###########################
# Private Network
###########################

# Subnets
module "private_subnet_cp_a" {
  source                  = "./modules/subnet"
  vpc_id                  = module.vpc.vpc_id
  cidr_block              = "10.0.3.0/24"
  availability_zone       = "eu-central-1a"
  map_public_ip_on_launch = false
  name                    = "${var.name}-private-control-plane-a"
}

module "private_subnet_cp_b" {
  source                  = "./modules/subnet"
  vpc_id                  = module.vpc.vpc_id
  cidr_block              = "10.0.4.0/24"
  availability_zone       = "eu-central-1b"
  map_public_ip_on_launch = false
  name                    = "${var.name}-private-control-plane-b"
}

module "private_subnet_worker_a" {
  source                  = "./modules/subnet"
  vpc_id                  = module.vpc.vpc_id
  cidr_block              = "10.0.5.0/24"
  availability_zone       = "eu-central-1a"
  map_public_ip_on_launch = false
  name                    = "${var.name}-private-worker-a"
}

module "private_subnet_worker_b" {
  source                  = "./modules/subnet"
  vpc_id                  = module.vpc.vpc_id
  cidr_block              = "10.0.6.0/24"
  availability_zone       = "eu-central-1b"
  map_public_ip_on_launch = false
  name                    = "${var.name}-private-worker-b"
}

module "private_subnet_db_a" {
  source                  = "./modules/subnet"
  vpc_id                  = module.vpc.vpc_id
  cidr_block              = "10.0.7.0/24"
  availability_zone       = "eu-central-1a"
  map_public_ip_on_launch = false
  name                    = "${var.name}-private-db-a"
}

module "private_subnet_db_b" {
  source                  = "./modules/subnet"
  vpc_id                  = module.vpc.vpc_id
  cidr_block              = "10.0.8.0/24"
  availability_zone       = "eu-central-1b"
  map_public_ip_on_launch = false
  name                    = "${var.name}-private-db-b"
}

# Elastic IPs
module "elastic_ip" {
  source           = "./modules/elastic_ip"
  elastic_ip_count = 2
  name_prefix      = "${var.name}-nat"
}

# NAT Gateways
module "nat_gateway" {
  source         = "./modules/nat_gateway"
  allocation_ids = module.elastic_ip.elastic_ips_allocations_ids
  subnet_ids     = [module.public_subnet_a.subnet_id, module.public_subnet_b.subnet_id]
  name_prefix    = "${var.name}-nat"
}

# Route Tables
module "private_route_table_a" {
  source = "./modules/route_table"
  vpc_id = module.vpc.vpc_id
  name   = "${var.name}-private-route-table-a"
}

module "private_route_table_b" {
  source = "./modules/route_table"
  vpc_id = module.vpc.vpc_id
  name   = "${var.name}-private-route-table-b"
}

# Routes
module "private_route_a" {
  source                 = "./modules/route"
  route_table_id         = module.private_route_table_a.route_table_id
  nat_gateway_id         = module.nat_gateway.nat_gateways_ids[0]
  destination_cidr_block = "0.0.0.0/0"
}

module "private_route_b" {
  source                 = "./modules/route"
  route_table_id         = module.private_route_table_b.route_table_id
  nat_gateway_id         = module.nat_gateway.nat_gateways_ids[1]
  destination_cidr_block = "0.0.0.0/0"
}

# Route Table Associations
module "private_route_table_assoc_cp_a" {
  source         = "./modules/route_table_association"
  subnet_id      = module.private_subnet_cp_a.subnet_id
  route_table_id = module.private_route_table_a.route_table_id
}

module "private_route_table_assoc_cp_b" {
  source         = "./modules/route_table_association"
  subnet_id      = module.private_subnet_cp_b.subnet_id
  route_table_id = module.private_route_table_b.route_table_id
}

module "private_route_table_assoc_worker_a" {
  source         = "./modules/route_table_association"
  subnet_id      = module.private_subnet_worker_a.subnet_id
  route_table_id = module.private_route_table_a.route_table_id
}

module "private_route_table_assoc_worker_b" {
  source         = "./modules/route_table_association"
  subnet_id      = module.private_subnet_worker_b.subnet_id
  route_table_id = module.private_route_table_b.route_table_id
}

module "private_route_table_assoc_db_a" {
  source         = "./modules/route_table_association"
  subnet_id      = module.private_subnet_db_a.subnet_id
  route_table_id = module.private_route_table_a.route_table_id
}

module "private_route_table_assoc_db_b" {
  source         = "./modules/route_table_association"
  subnet_id      = module.private_subnet_db_b.subnet_id
  route_table_id = module.private_route_table_b.route_table_id
}

###########################
# Security Groups
###########################

# Load Balancer Security Group
module "lb_sg" {
  source = "./modules/security_group"
  name   = "lb-sg"
  vpc_id = module.vpc.vpc_id
  ingress_rules = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
  egress_rules = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

# Private Security Group
module "private_sg" {
  source = "./modules/security_group"
  name   = "private-sg"
  vpc_id = module.vpc.vpc_id

  ingress_rules = [
    {
      from_port = 0
      to_port   = 0
      protocol  = "-1"
      sg_id     = module.lb_sg.sg_id
    }
  ]
  egress_rules = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

###########################
# Key Pairs
###########################

module "key_pair" {
  source     = "./modules/key_pair"
  name       = "${var.name}-key"
  public_key = file("~/.ssh/id_rsa_gameland.pub")
}

###########################
# EC2 Instances
###########################

# K3s Control Plane Instances
module "cp_ec2_instances" {
  source             = "./modules/ec2_instance"
  instance_count     = var.control_plane_count
  ami                = "ami-0f439e819ba112bd7"
  instance_type      = "t3.small"
  subnet_ids         = local.cp_subnets_ids
  security_group_ids = [module.private_sg.sg_id]
  key_name           = module.key_pair.key_name
  name_prefix        = "${var.name}-k3s-control-plane"
}

# Database Instances
module "db_ec2_instances" {
  source             = "./modules/ec2_instance"
  instance_count     = var.database_count
  ami                = "ami-0f439e819ba112bd7"
  instance_type      = "t3.small"
  subnet_ids         = local.db_subnets_ids
  security_group_ids = [module.private_sg.sg_id]
  key_name           = module.key_pair.key_name
  name_prefix        = "${var.name}-postgres-db"
}

###########################
# Application Load Balancers
###########################

module "alb" {
  source             = "./modules/application_load_balancer"
  name               = "${var.name}-alb"
  subnet_ids         = [module.public_subnet_a.subnet_id, module.public_subnet_b.subnet_id]
  security_group_ids = [module.lb_sg.sg_id]
  target_group_name  = "${var.name}-tg"
  target_port        = 80
  vpc_id             = module.vpc.vpc_id
}

###########################
# Autoscaling Groups
###########################

# Launch Templates
module "worker_lt" {
  source             = "./modules/launch_template"
  name_prefix        = "${var.name}-worker-"
  image_id           = "ami-0f439e819ba112bd7"
  instance_type      = "t3.medium"
  key_name           = module.key_pair.key_name
  security_group_ids = [module.private_sg.sg_id]
}

# Autoscaling Groups
module "workers_asg" {
  source             = "./modules/autoscaling_group"
  name               = "${var.name}-workers-asg"
  min_size           = var.worker_min
  max_size           = var.worker_max
  desired_capacity   = var.worker_min
  subnet_ids         = [module.private_subnet_worker_a.subnet_id, module.private_subnet_worker_b.subnet_id]
  launch_template_id = module.worker_lt.lt_id
  target_group_arns  = [module.alb.target_group_arn]
}

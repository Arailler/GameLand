###########################
# VPC
###########################

module "vpc" {
  source     = "../../modules/vpc"
  cidr_block = "10.0.0.0/16"
  name       = "${var.name}-vpc"
}

###########################
# Public Network
###########################

# Internet Gateway
module "internet_gateway" {
  source = "../../modules/internet_gateway"
  vpc_id = module.vpc.vpc_id
  name   = "${var.name}-igw"
}

# Subnets
module "public_subnet_a" {
  source                  = "../../modules/subnet"
  vpc_id                  = module.vpc.vpc_id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "eu-central-1a"
  map_public_ip_on_launch = true
  name                    = "${var.name}-public-subnet-a"
}

module "public_subnet_b" {
  source                  = "../../modules/subnet"
  vpc_id                  = module.vpc.vpc_id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "eu-central-1b"
  map_public_ip_on_launch = true
  name                    = "${var.name}-public-subnet-b"
}

# Route Tables
module "public_route_table" {
  source = "../../modules/route_table"
  vpc_id = module.vpc.vpc_id
  name   = "${var.name}-public-route-table"
}

# Routes
module "public_route" {
  source                 = "../../modules/route"
  route_table_id         = module.public_route_table.route_table_id
  gateway_id             = module.internet_gateway.ig_id
  destination_cidr_block = "0.0.0.0/0"
}


# Route Table Associations
module "public_route_table_assoc_a" {
  source         = "../../modules/route_table_association"
  subnet_id      = module.public_subnet_a.subnet_id
  route_table_id = module.public_route_table.route_table_id
}

module "public_route_table_assoc_b" {
  source         = "../../modules/route_table_association"
  subnet_id      = module.public_subnet_b.subnet_id
  route_table_id = module.public_route_table.route_table_id
}

###########################
# Private Network
###########################

# Subnets
module "private_subnet_cp_a" {
  source                  = "../../modules/subnet"
  vpc_id                  = module.vpc.vpc_id
  cidr_block              = "10.0.3.0/24"
  availability_zone       = "eu-central-1a"
  map_public_ip_on_launch = false
  name                    = "${var.name}-private-control-plane-a"
}

module "private_subnet_cp_b" {
  source                  = "../../modules/subnet"
  vpc_id                  = module.vpc.vpc_id
  cidr_block              = "10.0.4.0/24"
  availability_zone       = "eu-central-1b"
  map_public_ip_on_launch = false
  name                    = "${var.name}-private-control-plane-b"
}

module "private_subnet_worker_app_a" {
  source                  = "../../modules/subnet"
  vpc_id                  = module.vpc.vpc_id
  cidr_block              = "10.0.5.0/24"
  availability_zone       = "eu-central-1a"
  map_public_ip_on_launch = false
  name                    = "${var.name}-private-worker-app-a"
}

module "private_subnet_worker_app_b" {
  source                  = "../../modules/subnet"
  vpc_id                  = module.vpc.vpc_id
  cidr_block              = "10.0.6.0/24"
  availability_zone       = "eu-central-1b"
  map_public_ip_on_launch = false
  name                    = "${var.name}-private-worker-app-b"
}

module "private_subnet_worker_db_a" {
  source                  = "../../modules/subnet"
  vpc_id                  = module.vpc.vpc_id
  cidr_block              = "10.0.7.0/24"
  availability_zone       = "eu-central-1a"
  map_public_ip_on_launch = false
  name                    = "${var.name}-private-db-a"
}

module "private_subnet_worker_db_b" {
  source                  = "../../modules/subnet"
  vpc_id                  = module.vpc.vpc_id
  cidr_block              = "10.0.8.0/24"
  availability_zone       = "eu-central-1b"
  map_public_ip_on_launch = false
  name                    = "${var.name}-private-db-b"
}

# Elastic IPs
module "elastic_ip_a" {
  source = "../../modules/elastic_ip"
  name   = "${var.name}-nat-a"
}

module "elastic_ip_b" {
  source = "../../modules/elastic_ip"
  name   = "${var.name}-nat-b"
}

# NAT Gateways
module "nat_gateway_a" {
  source        = "../../modules/nat_gateway"
  allocation_id = module.elastic_ip_a.elastic_ip_allocation_id
  subnet_id     = module.public_subnet_a.subnet_id
  name          = "${var.name}-nat-a"
}

module "nat_gateway_b" {
  source        = "../../modules/nat_gateway"
  allocation_id = module.elastic_ip_b.elastic_ip_allocation_id
  subnet_id     = module.public_subnet_b.subnet_id
  name          = "${var.name}-nat-b"
}

# Route Tables
module "private_route_table_a" {
  source = "../../modules/route_table"
  vpc_id = module.vpc.vpc_id
  name   = "${var.name}-private-route-table-a"
}

module "private_route_table_b" {
  source = "../../modules/route_table"
  vpc_id = module.vpc.vpc_id
  name   = "${var.name}-private-route-table-b"
}

# Routes
module "private_route_a" {
  source                 = "../../modules/route"
  route_table_id         = module.private_route_table_a.route_table_id
  nat_gateway_id         = module.nat_gateway_a.nat_gateway_id
  destination_cidr_block = "0.0.0.0/0"
}

module "private_route_b" {
  source                 = "../../modules/route"
  route_table_id         = module.private_route_table_b.route_table_id
  nat_gateway_id         = module.nat_gateway_b.nat_gateway_id
  destination_cidr_block = "0.0.0.0/0"
}

# Route Table Associations
module "private_route_table_assoc_cp_a" {
  source         = "../../modules/route_table_association"
  subnet_id      = module.private_subnet_cp_a.subnet_id
  route_table_id = module.private_route_table_a.route_table_id
}

module "private_route_table_assoc_cp_b" {
  source         = "../../modules/route_table_association"
  subnet_id      = module.private_subnet_cp_b.subnet_id
  route_table_id = module.private_route_table_b.route_table_id
}

module "private_route_table_assoc_worker_app_a" {
  source         = "../../modules/route_table_association"
  subnet_id      = module.private_subnet_worker_app_a.subnet_id
  route_table_id = module.private_route_table_a.route_table_id
}

module "private_route_table_assoc_worker_app_b" {
  source         = "../../modules/route_table_association"
  subnet_id      = module.private_subnet_worker_app_b.subnet_id
  route_table_id = module.private_route_table_b.route_table_id
}

module "private_route_table_assoc_worker_db_a" {
  source         = "../../modules/route_table_association"
  subnet_id      = module.private_subnet_worker_db_a.subnet_id
  route_table_id = module.private_route_table_a.route_table_id
}

module "private_route_table_assoc_worker_db_b" {
  source         = "../../modules/route_table_association"
  subnet_id      = module.private_subnet_worker_db_b.subnet_id
  route_table_id = module.private_route_table_b.route_table_id
}

###########################
# Security Groups
###########################
# Bastion
module "bastion_sg" {
  source = "../../modules/security_group"
  name   = "bastion-sg"
  vpc_id = module.vpc.vpc_id

  ingress_rules = []

  egress_rules = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

module "bastion_ssh" {
  source            = "../../modules/security_group_rule"
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id = module.bastion_sg.sg_id
  cidr_blocks       = [local.my_ip]
  description       = "SSH"
}

# Control plane
module "cp_sg" {
  source        = "../../modules/security_group"
  name          = "cp-sg"
  vpc_id        = module.vpc.vpc_id
  ingress_rules = []
  egress_rules = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["10.0.0.0/16"]
    },
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]

}

module "cp_ssh_from_bastion" {
  source                   = "../../modules/security_group_rule"
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = module.cp_sg.sg_id
  source_security_group_id = module.bastion_sg.sg_id
  description              = "SSH from bastion"
}

module "cp_kube_api_from_cp" {
  source                   = "../../modules/security_group_rule"
  type                     = "ingress"
  from_port                = 6443
  to_port                  = 6443
  protocol                 = "tcp"
  security_group_id        = module.cp_sg.sg_id
  source_security_group_id = module.cp_sg.sg_id
  description              = "Kube API from control plane"
}

module "cp_kube_api_from_workers_app" {
  source                   = "../../modules/security_group_rule"
  type                     = "ingress"
  from_port                = 6443
  to_port                  = 6443
  protocol                 = "tcp"
  security_group_id        = module.cp_sg.sg_id
  source_security_group_id = module.workers_app_sg.sg_id
  description              = "Kube API from workers-app"
}

module "cp_kube_api_from_workers_db" {
  source                   = "../../modules/security_group_rule"
  type                     = "ingress"
  from_port                = 6443
  to_port                  = 6443
  protocol                 = "tcp"
  security_group_id        = module.cp_sg.sg_id
  source_security_group_id = module.workers_db_sg.sg_id
  description              = "Kube API from workers-db"
}

module "cp_kubelet_from_workers_app" {
  source                   = "../../modules/security_group_rule"
  type                     = "ingress"
  from_port                = 10250
  to_port                  = 10250
  protocol                 = "tcp"
  security_group_id        = module.cp_sg.sg_id
  source_security_group_id = module.workers_app_sg.sg_id
  description              = "Kubelet from workers-app"
}

module "cp_kubelet_from_workers_db" {
  source                   = "../../modules/security_group_rule"
  type                     = "ingress"
  from_port                = 10250
  to_port                  = 10250
  protocol                 = "tcp"
  security_group_id        = module.cp_sg.sg_id
  source_security_group_id = module.workers_db_sg.sg_id
  description              = "Kubelet from workers-db"
}

module "cp_node_exporter_from_workers_app" {
  source                   = "../../modules/security_group_rule"
  type                     = "ingress"
  from_port                = 9100
  to_port                  = 9100
  protocol                 = "tcp"
  security_group_id        = module.cp_sg.sg_id
  source_security_group_id = module.workers_app_sg.sg_id
  description              = "Node exporter from workers-app"
}

module "cp_core_dns_from_cp" {
  source                   = "../../modules/security_group_rule"
  type                     = "ingress"
  from_port                = 53
  to_port                  = 53
  protocol                 = "udp"
  security_group_id        = module.cp_sg.sg_id
  source_security_group_id = module.cp_sg.sg_id
  description              = "Core DNS from control plane"
}

module "cp_core_dns_from_workers_app" {
  source                   = "../../modules/security_group_rule"
  type                     = "ingress"
  from_port                = 53
  to_port                  = 53
  protocol                 = "udp"
  security_group_id        = module.cp_sg.sg_id
  source_security_group_id = module.workers_app_sg.sg_id
  description              = "Core DNS from workers-app"
}

module "cp_core_dns_from_workers_db" {
  source                   = "../../modules/security_group_rule"
  type                     = "ingress"
  from_port                = 53
  to_port                  = 53
  protocol                 = "udp"
  security_group_id        = module.cp_sg.sg_id
  source_security_group_id = module.workers_db_sg.sg_id
  description              = "Core DNS from workers-db"
}

module "cp_flannel_from_cp" {
  source                   = "../../modules/security_group_rule"
  type                     = "ingress"
  from_port                = 8472
  to_port                  = 8472
  protocol                 = "udp"
  security_group_id        = module.cp_sg.sg_id
  source_security_group_id = module.cp_sg.sg_id
  description              = "Flannel from control plane"
}

module "cp_flannel_from_workers_app" {
  source                   = "../../modules/security_group_rule"
  type                     = "ingress"
  from_port                = 8472
  to_port                  = 8472
  protocol                 = "udp"
  security_group_id        = module.cp_sg.sg_id
  source_security_group_id = module.workers_app_sg.sg_id
  description              = "Flannel from workers-app"
}

module "cp_flannel_from_workers_db" {
  source                   = "../../modules/security_group_rule"
  type                     = "ingress"
  from_port                = 8472
  to_port                  = 8472
  protocol                 = "udp"
  security_group_id        = module.cp_sg.sg_id
  source_security_group_id = module.workers_db_sg.sg_id
  description              = "Flannel from workers-db"
}

# Workers-app
module "workers_app_sg" {
  source        = "../../modules/security_group"
  name          = "workers-app-sg"
  vpc_id        = module.vpc.vpc_id
  ingress_rules = []
  egress_rules = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

module "workers_app_ssh_from_bastion" {
  source                   = "../../modules/security_group_rule"
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = module.workers_app_sg.sg_id
  source_security_group_id = module.bastion_sg.sg_id
  description              = "SSH from bastion"
}

module "workers_app_kubelet_from_cp" {
  source                   = "../../modules/security_group_rule"
  type                     = "ingress"
  from_port                = 10250
  to_port                  = 10250
  protocol                 = "tcp"
  security_group_id        = module.workers_app_sg.sg_id
  source_security_group_id = module.cp_sg.sg_id
  description              = "Kubelet from control plane"
}

module "workers_app_node_exporter_from_cp" {
  source                   = "../../modules/security_group_rule"
  type                     = "ingress"
  from_port                = 9100
  to_port                  = 9100
  protocol                 = "tcp"
  security_group_id        = module.workers_app_sg.sg_id
  source_security_group_id = module.cp_sg.sg_id
  description              = "Node exporter from control plane"
}

module "workers_app_node_exporter_from_workers_app" {
  source                   = "../../modules/security_group_rule"
  type                     = "ingress"
  from_port                = 9100
  to_port                  = 9100
  protocol                 = "tcp"
  security_group_id        = module.workers_app_sg.sg_id
  source_security_group_id = module.workers_app_sg.sg_id
  description              = "Node exporter from workers-app"
}

module "workers_app_node_exporter_from_workers_db" {
  source                   = "../../modules/security_group_rule"
  type                     = "ingress"
  from_port                = 9100
  to_port                  = 9100
  protocol                 = "tcp"
  security_group_id        = module.workers_app_sg.sg_id
  source_security_group_id = module.workers_db_sg.sg_id
  description              = "Node exporter from workers-db"
}

module "workers_app_core_dns_from_cp" {
  source                   = "../../modules/security_group_rule"
  type                     = "ingress"
  from_port                = 53
  to_port                  = 53
  protocol                 = "udp"
  security_group_id        = module.workers_app_sg.sg_id
  source_security_group_id = module.cp_sg.sg_id
  description              = "Core DNS from control plane"
}

module "workers_app_core_dns_from_workers_app" {
  source                   = "../../modules/security_group_rule"
  type                     = "ingress"
  from_port                = 53
  to_port                  = 53
  protocol                 = "udp"
  security_group_id        = module.workers_app_sg.sg_id
  source_security_group_id = module.workers_app_sg.sg_id
  description              = "Core DNS from workers-app"
}

module "workers_app_core_dns_from_workers_db" {
  source                   = "../../modules/security_group_rule"
  type                     = "ingress"
  from_port                = 53
  to_port                  = 53
  protocol                 = "udp"
  security_group_id        = module.workers_app_sg.sg_id
  source_security_group_id = module.workers_db_sg.sg_id
  description              = "Core DNS from workers-db"
}

module "workers_app_flannel_from_cp" {
  source                   = "../../modules/security_group_rule"
  type                     = "ingress"
  from_port                = 8472
  to_port                  = 8472
  protocol                 = "udp"
  security_group_id        = module.workers_app_sg.sg_id
  source_security_group_id = module.cp_sg.sg_id
  description              = "Flannel from control plane"
}

module "workers_app_flannel_from_workers_app" {
  source                   = "../../modules/security_group_rule"
  type                     = "ingress"
  from_port                = 8472
  to_port                  = 8472
  protocol                 = "udp"
  security_group_id        = module.workers_app_sg.sg_id
  source_security_group_id = module.workers_app_sg.sg_id
  description              = "Flannel from workers-app"
}

module "workers_app_flannel_from_workers_db" {
  source                   = "../../modules/security_group_rule"
  type                     = "ingress"
  from_port                = 8472
  to_port                  = 8472
  protocol                 = "udp"
  security_group_id        = module.workers_app_sg.sg_id
  source_security_group_id = module.workers_db_sg.sg_id
  description              = "Flannel from workers-db"
}

# Database
module "workers_db_sg" {
  source        = "../../modules/security_group"
  name          = "db-sg"
  vpc_id        = module.vpc.vpc_id
  ingress_rules = []
  egress_rules = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

module "workers_db_ssh_from_bastion" {
  source                   = "../../modules/security_group_rule"
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = module.workers_db_sg.sg_id
  source_security_group_id = module.bastion_sg.sg_id
  description              = "SSH from bastion"
}

module "workers_db_kubelet_from_cp" {
  source                   = "../../modules/security_group_rule"
  type                     = "ingress"
  from_port                = 10250
  to_port                  = 10250
  protocol                 = "tcp"
  security_group_id        = module.workers_db_sg.sg_id
  source_security_group_id = module.cp_sg.sg_id
  description              = "Kubelet from control plane"
}

module "workers_db_node_exporter_from_workers_app" {
  source                   = "../../modules/security_group_rule"
  type                     = "ingress"
  from_port                = 9100
  to_port                  = 9100
  protocol                 = "tcp"
  security_group_id        = module.workers_db_sg.sg_id
  source_security_group_id = module.workers_app_sg.sg_id
  description              = "Node exporter from workers-app"
}

module "workers_db_core_dns_from_cp" {
  source                   = "../../modules/security_group_rule"
  type                     = "ingress"
  from_port                = 53
  to_port                  = 53
  protocol                 = "udp"
  security_group_id        = module.workers_db_sg.sg_id
  source_security_group_id = module.cp_sg.sg_id
  description              = "Core DNS from control plane"
}

module "workers_db_core_dns_from_workers_app" {
  source                   = "../../modules/security_group_rule"
  type                     = "ingress"
  from_port                = 53
  to_port                  = 53
  protocol                 = "udp"
  security_group_id        = module.workers_db_sg.sg_id
  source_security_group_id = module.workers_app_sg.sg_id
  description              = "Core DNS from workers_app"
}

module "workers_db_core_dns_from_workers_db" {
  source                   = "../../modules/security_group_rule"
  type                     = "ingress"
  from_port                = 53
  to_port                  = 53
  protocol                 = "udp"
  security_group_id        = module.workers_db_sg.sg_id
  source_security_group_id = module.workers_db_sg.sg_id
  description              = "Core DNS from workers-db"
}

module "workers_db_flannel_from_cp" {
  source                   = "../../modules/security_group_rule"
  type                     = "ingress"
  from_port                = 8472
  to_port                  = 8472
  protocol                 = "udp"
  security_group_id        = module.workers_db_sg.sg_id
  source_security_group_id = module.cp_sg.sg_id
  description              = "Flannel from control plane"
}

module "workers_db_flannel_from_workers_app" {
  source                   = "../../modules/security_group_rule"
  type                     = "ingress"
  from_port                = 8472
  to_port                  = 8472
  protocol                 = "udp"
  security_group_id        = module.workers_db_sg.sg_id
  source_security_group_id = module.workers_app_sg.sg_id
  description              = "Flannel from workers-app"
}

module "workers_db_flannel_from_workers_db" {
  source                   = "../../modules/security_group_rule"
  type                     = "ingress"
  from_port                = 8472
  to_port                  = 8472
  protocol                 = "udp"
  security_group_id        = module.workers_db_sg.sg_id
  source_security_group_id = module.workers_db_sg.sg_id
  description              = "Flannel from workers-db"
}

###########################
# Key Pairs
###########################
module "key_pair" {
  source     = "../../modules/key_pair"
  name       = "${var.name}-key"
  public_key = file("~/.ssh/id_rsa_gameland.pub")
}

###########################
# Instance Profile
###########################
resource "aws_iam_role" "workers_role" {
  name = "${var.name}-workers-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy" "aws_lb_controller" {
  name        = "${var.name}-aws-lb-controller-policy"
  description = "IAM policy for AWS Load Balancer Controller on worker nodes"
  policy      = file("../../modules/iam_policy/policies/aws_lb_controller.json")
}

resource "aws_iam_role_policy_attachment" "workers_lb_controller" {
  role       = aws_iam_role.workers_role.name
  policy_arn = aws_iam_policy.aws_lb_controller.arn
}

resource "aws_iam_policy" "external_dns" {
  name        = "${var.name}-external-dns-policy"
  description = "IAM policy for ExternalDNS on worker nodes"
  policy      = file("../../modules/iam_policy/policies/external_dns.json")
}

resource "aws_iam_role_policy_attachment" "workers_external_dns" {
  role       = aws_iam_role.workers_role.name
  policy_arn = aws_iam_policy.external_dns.arn
}

resource "aws_iam_instance_profile" "workers_profile" {
  name = "${var.name}-workers-profile"
  role = aws_iam_role.workers_role.name
}

###########################
# EC2 Instances
###########################
# Bastion
module "bastion_ec2" {
  source             = "../../modules/ec2_instance"
  name_prefix        = "${var.name}-bastion"
  instance_count     = var.bastion_count
  ami                = var.bastion_ami
  instance_type      = var.bastion_size
  subnet_ids         = local.public_subnets_ids
  security_group_ids = [module.bastion_sg.sg_id]
  key_name           = module.key_pair.key_name
}

# Control plane
module "cp_ec2" {
  source             = "../../modules/ec2_instance"
  name_prefix        = "${var.name}-cp"
  instance_count     = var.cp_count
  ami                = var.cp_ami
  instance_type      = var.cp_size
  subnet_ids         = local.cp_subnets_ids
  security_group_ids = [module.cp_sg.sg_id]
  key_name           = module.key_pair.key_name
}

# Workers-app
module "workers_app_ec2" {
  source               = "../../modules/ec2_instance"
  name_prefix          = "${var.name}-worker-app"
  instance_count       = var.workers_app_count
  ami                  = var.workers_app_ami
  instance_type        = var.workers_app_size
  subnet_ids           = local.workers_app_subnets_ids
  security_group_ids   = [module.workers_app_sg.sg_id]
  key_name             = module.key_pair.key_name
  iam_instance_profile = aws_iam_instance_profile.workers_profile.name
}

# Workers-db
module "workers_db_ec2" {
  source               = "../../modules/ec2_instance"
  name_prefix          = "${var.name}-worker-db"
  instance_count       = var.workers_db_count
  ami                  = var.workers_db_ami
  instance_type        = var.workers_db_size
  subnet_ids           = local.workers_db_subnets_ids
  security_group_ids   = [module.workers_db_sg.sg_id]
  key_name             = module.key_pair.key_name
  iam_instance_profile = aws_iam_instance_profile.workers_profile.name
}

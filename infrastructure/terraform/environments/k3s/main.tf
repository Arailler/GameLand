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

module "private_subnet_worker_a" {
  source                  = "../../modules/subnet"
  vpc_id                  = module.vpc.vpc_id
  cidr_block              = "10.0.5.0/24"
  availability_zone       = "eu-central-1a"
  map_public_ip_on_launch = false
  name                    = "${var.name}-private-worker-a"
}

module "private_subnet_worker_b" {
  source                  = "../../modules/subnet"
  vpc_id                  = module.vpc.vpc_id
  cidr_block              = "10.0.6.0/24"
  availability_zone       = "eu-central-1b"
  map_public_ip_on_launch = false
  name                    = "${var.name}-private-worker-b"
}

module "private_subnet_db_a" {
  source                  = "../../modules/subnet"
  vpc_id                  = module.vpc.vpc_id
  cidr_block              = "10.0.7.0/24"
  availability_zone       = "eu-central-1a"
  map_public_ip_on_launch = false
  name                    = "${var.name}-private-db-a"
}

module "private_subnet_db_b" {
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

module "private_route_table_assoc_worker_a" {
  source         = "../../modules/route_table_association"
  subnet_id      = module.private_subnet_worker_a.subnet_id
  route_table_id = module.private_route_table_a.route_table_id
}

module "private_route_table_assoc_worker_b" {
  source         = "../../modules/route_table_association"
  subnet_id      = module.private_subnet_worker_b.subnet_id
  route_table_id = module.private_route_table_b.route_table_id
}

module "private_route_table_assoc_db_a" {
  source         = "../../modules/route_table_association"
  subnet_id      = module.private_subnet_db_a.subnet_id
  route_table_id = module.private_route_table_a.route_table_id
}

module "private_route_table_assoc_db_b" {
  source         = "../../modules/route_table_association"
  subnet_id      = module.private_subnet_db_b.subnet_id
  route_table_id = module.private_route_table_b.route_table_id
}

###########################
# Security Groups
###########################

# Load Balancer
module "lb_sg" {
  source = "../../modules/security_group"
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
module "control_plane_sg" {
  source        = "../../modules/security_group"
  name          = "control-plane-sg"
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
  security_group_id        = module.control_plane_sg.sg_id
  source_security_group_id = module.bastion_sg.sg_id
  description              = "SSH from bastion"
}

module "cp_kube_api_from_cp" {
  source                   = "../../modules/security_group_rule"
  type                     = "ingress"
  from_port                = 6443
  to_port                  = 6443
  protocol                 = "tcp"
  security_group_id        = module.control_plane_sg.sg_id
  source_security_group_id = module.control_plane_sg.sg_id
  description              = "Kube API from control plane"
}

module "cp_kube_api_from_workers" {
  source                   = "../../modules/security_group_rule"
  type                     = "ingress"
  from_port                = 6443
  to_port                  = 6443
  protocol                 = "tcp"
  security_group_id        = module.control_plane_sg.sg_id
  source_security_group_id = module.workers_sg.sg_id
  description              = "Kube API from workers"
}

module "cp_kube_api_from_database" {
  source                   = "../../modules/security_group_rule"
  type                     = "ingress"
  from_port                = 6443
  to_port                  = 6443
  protocol                 = "tcp"
  security_group_id        = module.control_plane_sg.sg_id
  source_security_group_id = module.database_sg.sg_id
  description              = "Kube API from database"
}

module "cp_kubelet_from_workers" {
  source                   = "../../modules/security_group_rule"
  type                     = "ingress"
  from_port                = 10250
  to_port                  = 10250
  protocol                 = "tcp"
  security_group_id        = module.control_plane_sg.sg_id
  source_security_group_id = module.workers_sg.sg_id
  description              = "Kubelet from workers"
}

module "cp_kubelet_from_database" {
  source                   = "../../modules/security_group_rule"
  type                     = "ingress"
  from_port                = 10250
  to_port                  = 10250
  protocol                 = "tcp"
  security_group_id        = module.control_plane_sg.sg_id
  source_security_group_id = module.database_sg.sg_id
  description              = "Kubelet from database"
}

module "cp_node_exporter_from_workers" {
  source                   = "../../modules/security_group_rule"
  type                     = "ingress"
  from_port                = 9100
  to_port                  = 9100
  protocol                 = "tcp"
  security_group_id        = module.control_plane_sg.sg_id
  source_security_group_id = module.workers_sg.sg_id
  description              = "Node exporter from workers"
}

module "cp_core_dns_from_cp" {
  source                   = "../../modules/security_group_rule"
  type                     = "ingress"
  from_port                = 53
  to_port                  = 53
  protocol                 = "udp"
  security_group_id        = module.control_plane_sg.sg_id
  source_security_group_id = module.control_plane_sg.sg_id
  description              = "Core DNS from control plane"
}

module "cp_core_dns_from_workers" {
  source                   = "../../modules/security_group_rule"
  type                     = "ingress"
  from_port                = 53
  to_port                  = 53
  protocol                 = "udp"
  security_group_id        = module.control_plane_sg.sg_id
  source_security_group_id = module.workers_sg.sg_id
  description              = "Core DNS from workers"
}

module "cp_core_dns_from_database" {
  source                   = "../../modules/security_group_rule"
  type                     = "ingress"
  from_port                = 53
  to_port                  = 53
  protocol                 = "udp"
  security_group_id        = module.control_plane_sg.sg_id
  source_security_group_id = module.database_sg.sg_id
  description              = "Core DNS from database"
}

module "cp_flannel_from_cp" {
  source                   = "../../modules/security_group_rule"
  type                     = "ingress"
  from_port                = 8472
  to_port                  = 8472
  protocol                 = "udp"
  security_group_id        = module.control_plane_sg.sg_id
  source_security_group_id = module.control_plane_sg.sg_id
  description              = "Flannel from control plane"
}

module "cp_flannel_from_workers" {
  source                   = "../../modules/security_group_rule"
  type                     = "ingress"
  from_port                = 8472
  to_port                  = 8472
  protocol                 = "udp"
  security_group_id        = module.control_plane_sg.sg_id
  source_security_group_id = module.workers_sg.sg_id
  description              = "Flannel from workers"
}

module "cp_flannel_from_database" {
  source                   = "../../modules/security_group_rule"
  type                     = "ingress"
  from_port                = 8472
  to_port                  = 8472
  protocol                 = "udp"
  security_group_id        = module.control_plane_sg.sg_id
  source_security_group_id = module.database_sg.sg_id
  description              = "Flannel from database"
}

# Workers
module "workers_sg" {
  source        = "../../modules/security_group"
  name          = "workers-sg"
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

module "workers_ssh_from_bastion" {
  source                   = "../../modules/security_group_rule"
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = module.workers_sg.sg_id
  source_security_group_id = module.bastion_sg.sg_id
  description              = "SSH from bastion"
}

module "workers_kubelet_from_cp" {
  source                   = "../../modules/security_group_rule"
  type                     = "ingress"
  from_port                = 10250
  to_port                  = 10250
  protocol                 = "tcp"
  security_group_id        = module.workers_sg.sg_id
  source_security_group_id = module.control_plane_sg.sg_id
  description              = "Kubelet from control plane"
}

module "workers_node_exporter_from_cp" {
  source                   = "../../modules/security_group_rule"
  type                     = "ingress"
  from_port                = 9100
  to_port                  = 9100
  protocol                 = "tcp"
  security_group_id        = module.workers_sg.sg_id
  source_security_group_id = module.control_plane_sg.sg_id
  description              = "Node exporter from control plane"
}

module "workers_node_exporter_from_workers" {
  source                   = "../../modules/security_group_rule"
  type                     = "ingress"
  from_port                = 9100
  to_port                  = 9100
  protocol                 = "tcp"
  security_group_id        = module.workers_sg.sg_id
  source_security_group_id = module.workers_sg.sg_id
  description              = "Node exporter from workers"
}

module "workers_node_exporter_from_database" {
  source                   = "../../modules/security_group_rule"
  type                     = "ingress"
  from_port                = 9100
  to_port                  = 9100
  protocol                 = "tcp"
  security_group_id        = module.workers_sg.sg_id
  source_security_group_id = module.database_sg.sg_id
  description              = "Node exporter from database"
}

module "workers_core_dns_from_cp" {
  source                   = "../../modules/security_group_rule"
  type                     = "ingress"
  from_port                = 53
  to_port                  = 53
  protocol                 = "udp"
  security_group_id        = module.workers_sg.sg_id
  source_security_group_id = module.control_plane_sg.sg_id
  description              = "Core DNS from control plane"
}

module "workers_core_dns_from_workers" {
  source                   = "../../modules/security_group_rule"
  type                     = "ingress"
  from_port                = 53
  to_port                  = 53
  protocol                 = "udp"
  security_group_id        = module.workers_sg.sg_id
  source_security_group_id = module.workers_sg.sg_id
  description              = "Core DNS from workers"
}

module "workers_core_dns_from_database" {
  source                   = "../../modules/security_group_rule"
  type                     = "ingress"
  from_port                = 53
  to_port                  = 53
  protocol                 = "udp"
  security_group_id        = module.workers_sg.sg_id
  source_security_group_id = module.database_sg.sg_id
  description              = "Core DNS from database"
}

module "workers_flannel_from_cp" {
  source                   = "../../modules/security_group_rule"
  type                     = "ingress"
  from_port                = 8472
  to_port                  = 8472
  protocol                 = "udp"
  security_group_id        = module.workers_sg.sg_id
  source_security_group_id = module.control_plane_sg.sg_id
  description              = "Flannel from control plane"
}

module "workers_flannel_from_workers" {
  source                   = "../../modules/security_group_rule"
  type                     = "ingress"
  from_port                = 8472
  to_port                  = 8472
  protocol                 = "udp"
  security_group_id        = module.workers_sg.sg_id
  source_security_group_id = module.workers_sg.sg_id
  description              = "Flannel from workers"
}

module "workers_flannel_from_database" {
  source                   = "../../modules/security_group_rule"
  type                     = "ingress"
  from_port                = 8472
  to_port                  = 8472
  protocol                 = "udp"
  security_group_id        = module.workers_sg.sg_id
  source_security_group_id = module.database_sg.sg_id
  description              = "Flannel from database"
}

module "workers_nodeport_gameland_from_alb" {
  source                   = "../../modules/security_group_rule"
  type                     = "ingress"
  from_port                = 30000
  to_port                  = 30000
  protocol                 = "tcp"
  security_group_id        = module.workers_sg.sg_id
  source_security_group_id = module.lb_sg.sg_id
  description              = "GameLand NodePort from ALB"
}

module "workers_nodeport_prometheus_from_alb" {
  source                   = "../../modules/security_group_rule"
  type                     = "ingress"
  from_port                = 30001
  to_port                  = 30001
  protocol                 = "tcp"
  security_group_id        = module.workers_sg.sg_id
  source_security_group_id = module.lb_sg.sg_id
  description              = "Prometheus NodePort from ALB"
}

module "workers_nodeport_grafana_from_alb" {
  source                   = "../../modules/security_group_rule"
  type                     = "ingress"
  from_port                = 30002
  to_port                  = 30002
  protocol                 = "tcp"
  security_group_id        = module.workers_sg.sg_id
  source_security_group_id = module.lb_sg.sg_id
  description              = "Grafana NodePort from ALB"
}

# Database
module "database_sg" {
  source        = "../../modules/security_group"
  name          = "database-sg"
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

module "database_ssh_from_bastion" {
  source                   = "../../modules/security_group_rule"
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = module.database_sg.sg_id
  source_security_group_id = module.bastion_sg.sg_id
  description              = "SSH from bastion"
}

module "database_kubelet_from_cp" {
  source                   = "../../modules/security_group_rule"
  type                     = "ingress"
  from_port                = 10250
  to_port                  = 10250
  protocol                 = "tcp"
  security_group_id        = module.database_sg.sg_id
  source_security_group_id = module.control_plane_sg.sg_id
  description              = "Kubelet from control plane"
}

module "database_node_exporter_from_workers" {
  source                   = "../../modules/security_group_rule"
  type                     = "ingress"
  from_port                = 9100
  to_port                  = 9100
  protocol                 = "tcp"
  security_group_id        = module.database_sg.sg_id
  source_security_group_id = module.workers_sg.sg_id
  description              = "Node exporter from workers"
}

module "database_core_dns_from_cp" {
  source                   = "../../modules/security_group_rule"
  type                     = "ingress"
  from_port                = 53
  to_port                  = 53
  protocol                 = "udp"
  security_group_id        = module.database_sg.sg_id
  source_security_group_id = module.control_plane_sg.sg_id
  description              = "Core DNS from control plane"
}

module "database_core_dns_from_workers" {
  source                   = "../../modules/security_group_rule"
  type                     = "ingress"
  from_port                = 53
  to_port                  = 53
  protocol                 = "udp"
  security_group_id        = module.database_sg.sg_id
  source_security_group_id = module.workers_sg.sg_id
  description              = "Core DNS from workers"
}

module "database_core_dns_from_database" {
  source                   = "../../modules/security_group_rule"
  type                     = "ingress"
  from_port                = 53
  to_port                  = 53
  protocol                 = "udp"
  security_group_id        = module.database_sg.sg_id
  source_security_group_id = module.database_sg.sg_id
  description              = "Core DNS from database"
}

module "database_flannel_from_cp" {
  source                   = "../../modules/security_group_rule"
  type                     = "ingress"
  from_port                = 8472
  to_port                  = 8472
  protocol                 = "udp"
  security_group_id        = module.database_sg.sg_id
  source_security_group_id = module.control_plane_sg.sg_id
  description              = "Flannel from control plane"
}

module "database_flannel_from_workers" {
  source                   = "../../modules/security_group_rule"
  type                     = "ingress"
  from_port                = 8472
  to_port                  = 8472
  protocol                 = "udp"
  security_group_id        = module.database_sg.sg_id
  source_security_group_id = module.workers_sg.sg_id
  description              = "Flannel from workers"
}

module "database_flannel_from_database" {
  source                   = "../../modules/security_group_rule"
  type                     = "ingress"
  from_port                = 8472
  to_port                  = 8472
  protocol                 = "udp"
  security_group_id        = module.database_sg.sg_id
  source_security_group_id = module.database_sg.sg_id
  description              = "Flannel from database"
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
# Application Load Balancers
###########################
module "gameland_alb" {
  source             = "../../modules/application_load_balancer"
  name               = "gameland-alb"
  subnet_ids         = local.public_subnets_ids
  security_group_ids = [module.lb_sg.sg_id]
}

module "gameland_tg" {
  source      = "../../modules/target_group"
  name        = "gameland-tg"
  port        = 30000
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = module.vpc.vpc_id

  health_check = {
    path                = "/"
    port                = "30000"
    protocol            = "HTTP"
    healthy_threshold   = 2
    unhealthy_threshold = 3
    interval            = 30
    timeout             = 5
  }
}

module "prometheus_tg" {
  source      = "../../modules/target_group"
  name        = "prometheus-tg"
  port        = 30001
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = module.vpc.vpc_id

  health_check = {
    path                = "/metrics"
    port                = "30001"
    protocol            = "HTTP"
    healthy_threshold   = 2
    unhealthy_threshold = 3
    interval            = 30
    timeout             = 5
  }
}

module "grafana_tg" {
  source      = "../../modules/target_group"
  name        = "grafana-tg"
  port        = 30002
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = module.vpc.vpc_id

  health_check = {
    path                = "/api/health"
    port                = "30002"
    protocol            = "HTTP"
    healthy_threshold   = 2
    unhealthy_threshold = 3
    interval            = 30
    timeout             = 5
  }
}

resource "aws_autoscaling_attachment" "workers_to_gameland_tg" {
  autoscaling_group_name = module.workers_asg.asg_name
  lb_target_group_arn    = module.gameland_tg.tg_arn
}

resource "aws_autoscaling_attachment" "workers_to_prometheus_tg" {
  autoscaling_group_name = module.workers_asg.asg_name
  lb_target_group_arn    = module.prometheus_tg.tg_arn
}

resource "aws_autoscaling_attachment" "workers_to_grafana_tg" {
  autoscaling_group_name = module.workers_asg.asg_name
  lb_target_group_arn    = module.grafana_tg.tg_arn
}

module "alb_listener_http" {
  source            = "../../modules/alb_listener"
  load_balancer_arn = module.gameland_alb.lb_arn
  port              = 80
  protocol          = "HTTP"
  default_action = {
    type             = "forward"
    target_group_arn = module.gameland_tg.tg_arn
  }
}

module "gameland_rule" {
  source           = "../../modules/alb_listener_rule"
  listener_arn     = module.alb_listener_http.listener_arn
  priority         = 100
  path_patterns    = ["/gameland/*"]
  target_group_arn = module.gameland_tg.tg_arn
}

module "prometheus_rule" {
  source           = "../../modules/alb_listener_rule"
  listener_arn     = module.alb_listener_http.listener_arn
  priority         = 110
  path_patterns    = ["/prometheus/*"]
  target_group_arn = module.prometheus_tg.tg_arn
}

module "grafana_rule" {
  source           = "../../modules/alb_listener_rule"
  listener_arn     = module.alb_listener_http.listener_arn
  priority         = 120
  path_patterns    = ["/grafana/*"]
  target_group_arn = module.grafana_tg.tg_arn
}

###########################
# Autoscaling Groups
###########################

# Launch Templates
module "bastion_lt" {
  source             = "../../modules/launch_template"
  name_prefix        = "${var.name}-bastion-"
  image_id           = var.bastion_ami
  instance_type      = var.bastion_size
  key_name           = module.key_pair.key_name
  security_group_ids = [module.bastion_sg.sg_id]
}

module "cp_lt" {
  source             = "../../modules/launch_template"
  name_prefix        = "${var.name}-cp-"
  image_id           = var.cp_ami
  instance_type      = var.cp_size
  key_name           = module.key_pair.key_name
  security_group_ids = [module.control_plane_sg.sg_id]
}

module "workers_lt" {
  source             = "../../modules/launch_template"
  name_prefix        = "${var.name}-worker-"
  image_id           = var.worker_ami
  instance_type      = var.worker_size
  key_name           = module.key_pair.key_name
  security_group_ids = [module.workers_sg.sg_id]
}

module "db_lt" {
  source             = "../../modules/launch_template"
  name_prefix        = "${var.name}-db-"
  image_id           = var.db_ami
  instance_type      = var.db_size
  key_name           = module.key_pair.key_name
  security_group_ids = [module.database_sg.sg_id]
}

# Autoscaling Groups
module "bastion_asg" {
  source             = "../../modules/autoscaling_group"
  name               = "${var.name}-bastion-asg"
  min_size           = var.bastion_min
  max_size           = var.bastion_max
  desired_capacity   = var.bastion_min
  subnet_ids         = local.public_subnets_ids
  launch_template_id = module.bastion_lt.lt_id
}

module "cp_asg" {
  source             = "../../modules/autoscaling_group"
  name               = "${var.name}-cp-asg"
  min_size           = var.cp_min
  max_size           = var.cp_max
  desired_capacity   = var.cp_min
  subnet_ids         = local.cp_subnets_ids
  launch_template_id = module.cp_lt.lt_id
}

module "workers_asg" {
  source             = "../../modules/autoscaling_group"
  name               = "${var.name}-workers-asg"
  min_size           = var.worker_min
  max_size           = var.worker_max
  desired_capacity   = var.worker_min
  subnet_ids         = local.workers_subnets_ids
  launch_template_id = module.workers_lt.lt_id
}

module "db_asg" {
  source             = "../../modules/autoscaling_group"
  name               = "${var.name}-db-asg"
  min_size           = var.db_min
  max_size           = var.db_max
  desired_capacity   = var.db_min
  subnet_ids         = local.db_subnets_ids
  launch_template_id = module.db_lt.lt_id
}

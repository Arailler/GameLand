output "alb_dns_name" {
  value = module.gameland_alb.alb_dns_name
}

output "bastion_private_ips" {
  value = module.bastion_ec2.private_ips
}

output "bastion_public_ips" {
  value = module.bastion_ec2.public_ips
}

output "cp_private_ips" {
  value = [for i in data.aws_instance.cp_instances : i.private_ip]
}

output "workers_private_ips" {
  value = [for i in data.aws_instance.workers_instances : i.private_ip]
}

output "db_private_ips" {
  value = [for i in data.aws_instance.db_instances : i.private_ip]
}

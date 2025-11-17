output "vpc_id" {
  value = module.vpc.vpc_id
}

output "bastion_public_ips" {
  value = module.bastion_ec2.public_ips
}

output "cp_private_ips" {
  value = module.cp_ec2.private_ips
}

output "workers_app_private_ips" {
  value = module.workers_app_ec2.private_ips
}

output "workers_db_private_ips" {
  value = module.workers_db_ec2.private_ips
}

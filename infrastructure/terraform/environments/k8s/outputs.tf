output "bastion_public_ips" {
  value = module.bastion_ec2.public_ips
}

output "cp_private_ips" {
  value = module.cp_ec2.private_ips
}

output "workers_private_ips" {
  value = module.workers_ec2.private_ips
}

output "db_private_ips" {
  value = module.db_ec2.private_ips
}

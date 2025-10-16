locals {
  my_ip               = "${chomp(data.http.my_ip.response_body)}/32"
  cp_subnets_ids      = [module.private_subnet_cp_a.subnet_id, module.private_subnet_cp_b.subnet_id]
  db_subnets_ids      = [module.private_subnet_db_a.subnet_id, module.private_subnet_db_b.subnet_id]
  workers_subnets_ids = [module.private_subnet_worker_a.subnet_id, module.private_subnet_worker_b.subnet_id]
  public_subnets_ids  = [module.public_subnet_a.subnet_id, module.public_subnet_b.subnet_id]
}

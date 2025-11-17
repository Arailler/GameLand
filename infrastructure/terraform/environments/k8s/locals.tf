locals {
  my_ip                   = "${chomp(data.http.my_ip.response_body)}/32"
  cp_subnets_ids          = [module.private_subnet_cp_a.subnet_id, module.private_subnet_cp_b.subnet_id]
  workers_db_subnets_ids  = [module.private_subnet_worker_db_a.subnet_id, module.private_subnet_worker_db_b.subnet_id]
  workers_app_subnets_ids = [module.private_subnet_worker_app_a.subnet_id, module.private_subnet_worker_app_b.subnet_id]
  public_subnets_ids      = [module.public_subnet_a.subnet_id, module.public_subnet_b.subnet_id]
}

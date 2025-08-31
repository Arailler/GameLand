locals {
  cp_subnets_ids = [module.private_subnet_cp_a.subnet_id, module.private_subnet_cp_b.subnet_id]
  db_subnets_ids = [module.private_subnet_db_a.subnet_id, module.private_subnet_db_b.subnet_id]
}
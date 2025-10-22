data "http" "my_ip" {
  url = "https://checkip.amazonaws.com/"
}

data "aws_instances" "cp_asg_instances" {
  filter {
    name   = "tag:aws:autoscaling:groupName"
    values = [module.cp_asg.asg_name]
  }
}

data "aws_instance" "cp_instances" {
  for_each    = toset(data.aws_instances.cp_asg_instances.ids)
  instance_id = each.value
}

data "aws_instances" "workers_asg_instances" {
  filter {
    name   = "tag:aws:autoscaling:groupName"
    values = [module.workers_asg.asg_name]
  }
}

data "aws_instance" "workers_instances" {
  for_each    = toset(data.aws_instances.workers_asg_instances.ids)
  instance_id = each.value
}

data "aws_instances" "db_asg_instances" {
  filter {
    name   = "tag:aws:autoscaling:groupName"
    values = [module.db_asg.asg_name]
  }
}

data "aws_instance" "db_instances" {
  for_each    = toset(data.aws_instances.db_asg_instances.ids)
  instance_id = each.value
}

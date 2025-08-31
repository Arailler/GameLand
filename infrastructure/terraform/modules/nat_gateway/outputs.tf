output "nat_gateways_ids" {
  description = "List of NAT Gateway IDs"
  value       = aws_nat_gateway.this[*].id
}

output "nat_gateways_ips" {
  description = "List of Elastic IPs attached to the NAT gateways"
  value       = aws_nat_gateway.this[*].public_ip
}

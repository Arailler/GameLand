output "nat_gateway_id" {
  description = "The NAT Gateway ID"
  value       = aws_nat_gateway.this.id
}

output "nat_gateways_ip" {
  description = "The Elastic IP attached to the NAT gateway"
  value       = aws_nat_gateway.this.public_ip
}

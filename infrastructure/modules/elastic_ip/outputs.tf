output "elastic_ips_ids" {
  description = "List of Elastic IP IDs"
  value       = aws_eip.this[*].id
}

output "elastic_ips_allocations_ids" {
  description = "List of Elastic IP allocation IDs (needed for NAT Gateway)"
  value       = aws_eip.this[*].allocation_id
}

output "elastic_public_ips" {
  description = "List of Elastic Public IPs"
  value       = aws_eip.this[*].public_ip
}

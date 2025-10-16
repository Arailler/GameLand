output "elastic_ip_id" {
  description = "The Elastic IP ID"
  value       = aws_eip.this.id
}

output "elastic_ip_allocation_id" {
  description = "The Elastic IP allocation ID"
  value       = aws_eip.this.allocation_id
}

output "elastic_public_ip" {
  description = "The Elastic Public IP"
  value       = aws_eip.this.public_ip
}

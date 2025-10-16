output "instance_profile_name" {
  description = "Nom de l'instance profile"
  value       = aws_iam_instance_profile.this.name
}

output "instance_profile_arn" {
  description = "ARN de l'instance profile"
  value       = aws_iam_instance_profile.this.arn
}
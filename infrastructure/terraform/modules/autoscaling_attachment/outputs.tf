output "asg_attachments" {
  value = aws_autoscaling_attachment.this[*].id
}

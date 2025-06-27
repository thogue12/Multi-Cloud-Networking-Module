output "security_group_ids" {
  description = "List of all security group IDs"
  value = {for k, v in aws_security_group.this : k => v.id}
}

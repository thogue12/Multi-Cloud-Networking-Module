###

output "public_route_table_id" {
  description = "ID of the route table"
  value       = {for k, v in aws_route_table.public : k =>v.id}
}

output "private_route_table_id" {
  description = "ID of the route table"
  value       = {for k, v in aws_route_table.private : k => v.id}
}
output "this_connection" {
  value = { for k, v in aws_vpc_peering_connection.this_connection : k => v.id }
}
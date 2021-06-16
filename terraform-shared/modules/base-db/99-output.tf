output "db_client_sg_id" {
  value = aws_security_group.db_client.id
}

output "db_fqdn" {
  value = aws_route53_record.db.fqdn
}

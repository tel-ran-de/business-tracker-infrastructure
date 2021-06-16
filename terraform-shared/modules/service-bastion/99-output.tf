output "bastion_sg_id" {
  value = aws_security_group.bastion.id
}

output "bastion_fqdn" {
  value = aws_route53_record.bastion.fqdn
}

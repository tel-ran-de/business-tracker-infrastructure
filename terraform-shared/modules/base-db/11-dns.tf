resource "aws_route53_record" "db" {
  zone_id = var.dns_zone_id
  name    = local.db_dns_name
  type    = "CNAME"
  ttl     = "300"
  records = [aws_db_instance.base.address]
}

resource "aws_route53_record" "backend" {
  zone_id = var.dns_zone_id
  name = var.admin_backend_domain
  type = "CNAME"
  ttl = "120"
  records = [
    aws_alb.vpn_backend_alb.dns_name]
}

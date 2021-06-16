resource "aws_route53_record" "app" {
  count = length(var.dns_names)
  name    = var.dns_names[count.index]

  zone_id = var.dns_zone_id
  type    = "CNAME"
  ttl     = "120"

  records = [ aws_alb.app.dns_name ]
}

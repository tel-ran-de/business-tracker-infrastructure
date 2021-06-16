resource "aws_route53_record" "bastion" {
  zone_id = var.dns_zone_id
  name    = "bastion"
  type    = "A"
  ttl     = "60"
  records = [ aws_instance.bastion.public_ip ]
}

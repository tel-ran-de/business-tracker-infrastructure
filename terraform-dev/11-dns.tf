data "aws_route53_zone" "master" {
  zone_id      = var.base_dns_zone_id
  private_zone = false
}


resource "aws_route53_zone" "internal" {
  name    = "internal"

  vpc {
    vpc_id  =  module.vpc.vpc_id
  }

  tags = {
    Name = "${local.prefix}-internal-zone"
  }
}

resource "aws_route53_record" "internal-ns" {
  zone_id = aws_route53_zone.internal.zone_id
  name    = "internal-ns"
  type    = "NS"
  ttl     = "30"

  records = [
    aws_route53_zone.internal.name_servers.0,
    aws_route53_zone.internal.name_servers.1,
    aws_route53_zone.internal.name_servers.2,
    aws_route53_zone.internal.name_servers.3
  ]
}

resource "aws_route53_record" "app" {
  count = length(var.dns_names)
  name    = var.dns_names[count.index]

  zone_id = var.dns_zone_id
  type = "A"

  alias {
    evaluate_target_health = false
    name = aws_alb.fargate_service.dns_name
    zone_id = aws_alb.fargate_service.zone_id
  }
}

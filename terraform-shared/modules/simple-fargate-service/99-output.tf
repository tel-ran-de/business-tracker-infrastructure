output "alb_dns_name" {
  value = aws_alb.fargate_service.dns_name
}

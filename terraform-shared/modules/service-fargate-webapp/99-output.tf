output "app_security_group_id" {
  value = aws_security_group.app.id
}

output "alb_https_listener_arn" {
  value = aws_alb_listener.app-https.arn
}

output "aws_alb_app_tg_arn" {
  value = aws_alb_target_group.app.arn
}

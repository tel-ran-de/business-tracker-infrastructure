output "vpn_backend_tg_arn" {
  value = aws_alb_target_group.vpn_backend_tg.arn
}

output "vpn_backend_sg_id" {
  value = aws_security_group.vpn_backend_alb_sg.id
}

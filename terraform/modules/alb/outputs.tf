output "alb_security_group_id" {
  value = aws_security_group.alb.id
}

output "default_alb_target_group" {
  value = aws_alb_target_group.default.arn
}

output "http_alb_listener" {
  value = aws_alb_listener.http
}
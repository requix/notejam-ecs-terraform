resource "aws_cloudwatch_log_group" "flask-log-group" {
  name              = "/ecs/notejam-flask"
  retention_in_days = var.log_retention_in_days
}

resource "aws_cloudwatch_log_stream" "flask-log-stream" {
  name           = "flask-app-log-stream"
  log_group_name = aws_cloudwatch_log_group.flask-log-group.name
}

resource "aws_cloudwatch_log_group" "nginx-log-group" {
  name              = "/ecs/nginx"
  retention_in_days = var.log_retention_in_days
}

resource "aws_cloudwatch_log_stream" "nginx-log-stream" {
  name           = "nginx-log-stream"
  log_group_name = aws_cloudwatch_log_group.nginx-log-group.name
}

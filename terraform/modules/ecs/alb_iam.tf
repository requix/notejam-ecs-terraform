resource "aws_iam_role" "ecs_lb_role" {
  name = "${var.environment}_ecs_lb_role"
  path = "/ecs/"
  assume_role_policy = file("${path.root}/policies/loadbalancer_assume_role.json")
}

resource "aws_iam_role_policy_attachment" "ecs_lb" {
  role       = aws_iam_role.ecs_lb_role.id
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceRole"
}
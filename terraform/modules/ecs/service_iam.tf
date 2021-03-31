resource "aws_iam_role" "ecs_service_role" {
  name               = "ecs_service_role_prod"
  assume_role_policy = file("${path.root}/policies/ecs_service_assume_role.json")
}

resource "aws_iam_role_policy" "ecs_service_role_policy" {
  name   = "ecs_service_role_policy"
  policy = file("${path.root}/policies/ecs_service_policy.json")
  role   = aws_iam_role.ecs_service_role.id
}
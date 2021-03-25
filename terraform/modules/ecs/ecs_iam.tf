resource "aws_iam_role" "ecs_instance_role" {
  name = "${var.environment}_ecs_instance_role"
  assume_role_policy = file("../policies/assume_role_policy.json")
}

resource "aws_iam_instance_profile" "ecs" {
  name = "${var.environment}_ecs_instance_profile"
  path = "/"
  role = aws_iam_role.ecs_instance_role.name
}

resource "aws_iam_role_policy_attachment" "ecs_ec2_role" {
  role       = aws_iam_role.ecs_instance_role.id
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

resource "aws_iam_user" "ecs_deployer" {
  name = "ecs_deployer"
  path = "/ecs/"
}

resource "aws_iam_user_policy" "ecs_deployer_policy" {
  name = "ecs_deployer_policy"
  user = aws_iam_user.ecs_deployer.name
  policy = file("../policies/ecs_deployer_policy.json")
}

resource "aws_iam_access_key" "ecs_deployer" {
  user = aws_iam_user.ecs_deployer.name
}
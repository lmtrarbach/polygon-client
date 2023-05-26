module "vpc" {
 name            = var.vpc_name
 source          = "terraform-aws-modules/vpc/aws"
 enable_nat_gateway  = true

 cidr            = "10.0.0.0/16"
 azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
 private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
 public_subnets = ["10.0.101.0/24", "10.0.102.0/24"]
}

module "ecs_role" {
  source = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"

  role_name          = "ecs-fargate-role"
  role_description   = "IAM role for ECS Fargate"
  custom_role_policy_arns        = [
    "arn:aws:iam::aws:policy/AmazonECS_FullAccess",
    "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
  ]
}

resource "aws_iam_role" "ecs_execution_role" {
  name = "ecs-execution-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "ecs_execution_role_policy" {
  role       = aws_iam_role.ecs_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

module "ecs" {
  source = "../../modules/ecs"

  environment    = var.environment
  cluster_name   = var.cluster_name
  task_name      = var.task_name
  container_name = var.container_name
  docker_image   = var.docker_image
  service_name   = var.service_name
  desired_count  = var.desired_count
  vpc_id         = module.vpc.default_vpc_id
  security_groups = [module.vpc.default_security_group_id]
  private_subnets = module.vpc.private_subnets
  task_role_arn   = module.ecs_role.iam_role_arn
  execution_role  = aws_iam_role.ecs_execution_role.arn
}
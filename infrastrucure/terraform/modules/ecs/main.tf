resource "aws_ecs_cluster" "ecscluster" {
  name = var.cluster_name
}

resource "aws_cloudwatch_log_group" "ecs_log_group" {
  name = "/ecs/${var.container_name}"
  retention_in_days = 7
}

resource "aws_ecs_task_definition" "task_definition" {
  family                   = var.task_name
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  memory                   = 2048
  cpu                      = 1024
  task_role_arn            = var.task_role_arn
  execution_role_arn       = var.execution_role
  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }

  container_definitions = <<EOF
  [
    {
      "name": "${var.container_name}",
      "image": "${var.docker_image}",
      "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
          "awslogs-group": "${var.container_name}",
          "awslogs-region": "us-east-1",
          "awslogs-stream-prefix": "ecs"
        }
      },
      "environment": [
        {
          "name": "ENV",
          "value": "${var.environment}"
        }
      ]
    }
  ]
  EOF
}

resource "aws_ecs_service" "service" {
  name            = var.service_name
  cluster         = aws_ecs_cluster.ecscluster.id
  task_definition = aws_ecs_task_definition.task_definition.arn
  desired_count   = var.desired_count

  network_configuration {
    security_groups = var.security_groups
    subnets         = var.private_subnets
  }
}

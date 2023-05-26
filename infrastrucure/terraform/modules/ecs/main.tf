provider "aws" {
  region = "us-east-1"
}

resource "aws_ecs_cluster" "ecscluster" {
  name = var.cluster_name
}

resource "aws_ecs_task_definition" "task_definition" {
  family                   = var.task_name
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  memory                   = 2048
  cpu                      = 1024
  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }

  container_definitions    = <<EOF
  [
    {
      "name": "${var.container_name}",
      "image": "${var.docker_image}"
      ,
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
    subnets = var.private_subnets
  }
}

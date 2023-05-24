provider "aws" {
  region = "us-east-1"
}

resource "aws_ecs_cluster" "ecscluster" {
  name = var.cluster_name
}

resource "aws_ecs_task_definition" "task_definition" {
  family                   = var.task_name
  container_definitions    = <<EOF
  [
    {
      "name": "${var.container_name}",
      "image": "${var.docker_image}",
      "portMappings": [
        {
          "containerPort": 80,
          "hostPort": 80,
          "protocol": "tcp"
        }
      ],
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
}

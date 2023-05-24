module "ecs" {
  source = "../../modules/ecs"

  environment    = var.environment
  cluster_name   = var.cluster_name
  task_name      = var.task_name
  container_name = var.container_name
  docker_image   = var.docker_image
  service_name   = var.service_name
  desired_count  = var.desired_count
  vpc_id         = var.vpc_id
}
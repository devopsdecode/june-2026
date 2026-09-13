output "alb_dns_name" {
  description = "The public DNS name of the Application Load Balancer"
  value       = "http://${aws_lb.main.dns_name}"
}

output "ecs_cluster_name" {
  description = "The name of the ECS cluster"
  value       = aws_ecs_cluster.main.name
}

output "ecs_service_name" {
  description = "The name of the ECS service"
  value       = aws_ecs_service.main.name
}

output "task_definition_family" {
  description = "Family of the ECS Task Definition"
  value       = aws_ecs_task_definition.app.family
}

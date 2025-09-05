output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.gym_platform_vpc.id
}

output "public_subnet_1a_id" {
  description = "ID of the public subnet in AZ 1a"
  value       = aws_subnet.gym_platform_public_subnet_1a.id
}

output "public_subnet_1c_id" {
  description = "ID of the public subnet in AZ 1c"
  value       = aws_subnet.gym_platform_public_subnet_1c.id
}

output "private_subnet_1a_id" {
  description = "ID of the private subnet in AZ 1a"
  value       = aws_subnet.gym_platform_private_subnet_1a.id
}

output "private_subnet_1c_id" {
  description = "ID of the private subnet in AZ 1c"
  value       = aws_subnet.gym_platform_private_subnet_1c.id
}

output "alb_dns_name" {
  description = "DNS name of the load balancer"
  value       = aws_lb.gym_platform_alb.dns_name
}

output "alb_zone_id" {
  description = "Zone ID of the load balancer"
  value       = aws_lb.gym_platform_alb.zone_id
}

output "ecs_cluster_id" {
  description = "ID of the ECS cluster"
  value       = aws_ecs_cluster.gym_platform_cluster.id
}

output "ecs_cluster_name" {
  description = "Name of the ECS cluster"
  value       = aws_ecs_cluster.gym_platform_cluster.name
}

output "database_endpoint" {
  description = "RDS instance endpoint"
  value       = aws_db_instance.gym_platform_db.endpoint
  sensitive   = true
}

output "database_port" {
  description = "RDS instance port"
  value       = aws_db_instance.gym_platform_db.port
}

output "ecr_repository_url_app" {
  description = "URL of the ECR repository for the app"
  value       = aws_ecr_repository.gym_platform_app.repository_url
}

output "ecr_repository_url_frontend" {
  description = "URL of the ECR repository for the frontend"
  value       = aws_ecr_repository.gym_platform_frontend.repository_url
}

output "s3_bucket_assets" {
  description = "Name of the S3 bucket for assets"
  value       = aws_s3_bucket.gym_platform_assets.bucket
}

output "application_url" {
  description = "URL to access the application"
  value       = "http://${aws_lb.gym_platform_alb.dns_name}"
}

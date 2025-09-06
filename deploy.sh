#!/bin/bash

# Get ECR URLs from Terraform
cd infrastructure
ECR_APP_URL=$(terraform output -raw ecr_repository_url_app)
ECR_FRONTEND_URL=$(terraform output -raw ecr_repository_url_frontend)
CLUSTER_NAME=$(terraform output -raw ecs_cluster_name)

# Login to ECR
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin $ECR_APP_URL

# Build and push backend
cd ../backend
docker build --platform linux/amd64 -t $ECR_APP_URL:latest .
docker push $ECR_APP_URL:latest

# Build and push frontend
cd ../frontend
docker build --platform linux/amd64 -t $ECR_FRONTEND_URL:latest .
docker push $ECR_FRONTEND_URL:latest

# Update ECS services
aws ecs update-service --cluster $CLUSTER_NAME --service gym-platform-backend-service --force-new-deployment
aws ecs update-service --cluster $CLUSTER_NAME --service gym-platform-frontend-service --force-new-deployment

echo "Deployment complete!"
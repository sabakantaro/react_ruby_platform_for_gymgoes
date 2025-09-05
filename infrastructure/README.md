# React Ruby Gym Platform - Infrastructure

This directory contains Terraform configuration files for deploying the React Ruby Gym Platform to AWS using ECS Fargate.

## Architecture

- **VPC**: Custom VPC with public and private subnets across 2 availability zones
- **ECS Fargate**: Containerized application deployment
- **ALB**: Application Load Balancer for traffic distribution
- **RDS PostgreSQL**: Managed database service
- **ECR**: Container registry for Docker images
- **S3**: Storage for assets and ALB logs
- **CloudWatch**: Logging and monitoring

## Services

- **Frontend**: React application (port 3000)
- **Backend**: Rails API (port 3001)
- **Database**: PostgreSQL on RDS
- **Load Balancer**: Routes `/api/*` to backend, `/*` to frontend

## Prerequisites

1. **Terraform**: Install Terraform >= 1.0
2. **AWS CLI**: Configure AWS credentials
3. **IAM Role**: Create `ecsTaskExecutionRole` in AWS IAM

### Creating the ECS Task Execution Role

```bash
aws iam create-role --role-name ecsTaskExecutionRole \
  --assume-role-policy-document '{
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
  }'

aws iam attach-role-policy \
  --role-name ecsTaskExecutionRole \
  --policy-arn arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy
```

## Setup

1. **Copy the example variables file**:
   ```bash
   cp terraform.tfvars.example terraform.tfvars
   ```

2. **Edit terraform.tfvars**:
   ```bash
   # Update with your AWS credentials and preferences
   vim terraform.tfvars
   ```

3. **Initialize Terraform**:
   ```bash
   terraform init
   ```

4. **Plan the deployment**:
   ```bash
   terraform plan
   ```

5. **Apply the configuration**:
   ```bash
   terraform apply
   ```

## Configuration Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `aws_access_key` | AWS access key | - |
| `aws_secret_key` | AWS secret key | - |
| `aws_account_id` | AWS account ID | - |
| `database_name` | RDS database name | `gym_platform_db` |
| `database_username` | RDS username | - |
| `database_password` | RDS password | - |
| `r_prefix` | Resource naming prefix | `gym-platform` |
| `environment` | Environment name | `production` |

## Outputs

After deployment, Terraform will output:

- `application_url`: URL to access the application
- `alb_dns_name`: Load balancer DNS name
- `ecr_repository_url_app`: ECR repository for backend
- `ecr_repository_url_frontend`: ECR repository for frontend
- `database_endpoint`: RDS database endpoint

## GitHub Actions Integration

The infrastructure works with the GitHub Actions workflow in `.github/workflows/main.yml`:

1. **Repository Secrets**: Add these secrets to your GitHub repository:
   - `AWS_ACCESS_KEY_ID`
   - `AWS_SECRET_ACCESS_KEY`

2. **ECR Repositories**: The workflow pushes images to:
   - `gym-platform-app` (backend)
   - `gym-platform-frontend` (frontend)

## Deployment Flow

1. **Push to main/develop** → Triggers GitHub Actions
2. **Build Docker images** → Push to ECR
3. **Update ECS task definition** → Deploy to Fargate
4. **Health checks** → ALB routes traffic to healthy containers

## Cost Optimization

- **RDS**: Uses `db.t3.micro` for cost efficiency
- **ECS**: Uses Fargate Spot pricing when possible
- **S3**: Lifecycle policies for log retention
- **CloudWatch**: 7-day log retention

## Monitoring

- **CloudWatch Logs**: Application logs from containers
- **ECS Container Insights**: Enabled for cluster monitoring
- **ALB Access Logs**: Stored in S3

## Scaling

- **Auto Scaling**: Configure ECS service auto scaling
- **Database**: RDS supports read replicas and Multi-AZ
- **Load Balancer**: ALB automatically scales

## Security Features

- **Security Groups**: Restrictive ingress/egress rules
- **Private Subnets**: Database in private subnets
- **Encrypted Storage**: RDS encryption enabled
- **IAM Roles**: Least privilege access

## Cleanup

To destroy the infrastructure:

```bash
terraform destroy
```

## Troubleshooting

### Common Issues

1. **ECS Task Execution Role**: Ensure the role exists and has proper permissions
2. **Security Groups**: Check that ports are properly configured
3. **Subnets**: Ensure public subnets have internet gateway route
4. **ECR Images**: Verify images are pushed before ECS deployment

### Useful Commands

```bash
# Check ECS service status
aws ecs describe-services --cluster gym-platform-cluster --services gym-platform-backend-service

# View ECS task logs
aws logs describe-log-groups --log-group-name-prefix /ecs/gym-platform

# Check ALB health
aws elbv2 describe-target-health --target-group-arn <target-group-arn>
```

## Support

For issues with the infrastructure setup, check:
1. Terraform plan output for resource conflicts
2. AWS CloudFormation events for detailed error messages
3. ECS service events for deployment issues
4. CloudWatch logs for application errors

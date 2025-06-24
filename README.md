# CI-CD-EKS-with-RDS-MSQL

## Architecture Overview

Client → LoadBalancer (EKS Service)
↓
┌────────────┐
│ Frontend │ (HTML)
└────────────┘
↓
┌────────────┐
│ Backend │ (Node.js)
└────────────┘
↓
Amazon RDS (MySQL)



## Infrastructure Setup (Terraform)

Inside the `terraform/` folder you'll find:

- `vpc.tf` – Creates VPC, public/private subnets, route tables, and Internet Gateway
- `main.tf` – Provisions EKS cluster and worker node group using a launch template,Creates a MySQL DB in private subnets with secured SG
- `iam.tf` – IAM roles and policies for EKS & EC2
- `outputs.tf` – Outputs for DB endpoint and cluster info
- `variables.tf` – Input variables

### To deploy:
cd terraform/
terraform init
terraform validate
terraform plan -out=tfplan
terraform apply tfplan

Ensure:
You’ve created a key pair for SSH (optional)
You’ve set aws configure with proper credentials
The EKS cluster gets created in private subnets, RDS is private too


Docker & ECR
Both the frontend and backend apps are dockerized.

 Login to ECR
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin <account_id>.dkr.ecr.us-east-1.amazonaws.com

# Build, tag and push frontend
docker build -t frontend ./frontend
docker tag frontend:latest <account_id>.dkr.ecr.us-east-1.amazonaws.com/frontend:latest
docker push <account_id>.dkr.ecr.us-east-1.amazonaws.com/frontend:latest

 GitHub Actions CI/CD
Located in .github/workflows/deploy.yml.

It does:
Build Docker images for both apps

Push to ECR

Deploy updated containers to EKS using kubectl

Make sure to store the following secrets in GitHub:

Secret Name	         Description
AWS_ACCESS_KEY_ID	AWS IAM Access Key
AWS_SECRET_ACCESS_KEY	AWS IAM Secret Key
AWS_REGION	        e.g. us-east-1
ECR_REPO_FRONTEND	ECR URL for frontend
ECR_REPO_BACKEND	ECR URL for backend

 Kubernetes Deployment
Located in the yaml folder:

deployment.yaml – Deploys both frontend & backend in one pod
service.yaml – LoadBalancer exposing frontend
secret.yaml – Stores RDS DB password

Deploy manually:
kubectl apply -f k8s/secret.yaml
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml

Environment Variables (Backend)
Variable	Description
DB_HOST	RDS endpoint
DB_USER	DB username (e.g., admin)
DB_PASSWORD	Stored in Kubernetes secret
DB_NAME	e.g., appdb

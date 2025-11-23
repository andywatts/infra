# Infrastructure

Infrastructure as Code for multi-cloud deployments (AWS, GCP).

## 🏗️ Structure

```
aws/
  cdk/                  # AWS CDK projects
    aws-cdk-ecs/       # ECS infrastructure
    cdk-events/        # EventBridge examples
    cdk-lambda-layers/ # Lambda layers
    step-function-*/   # Step Functions workflows
  lambda-sam/          # AWS SAM projects
    sam-full-stack/    # Full-stack serverless app
    sam-multistep-*/   # Workflow examples

gcp/
  org/                 # GCP organization & projects
  projects/
    dev/               # Dev environment (GKE, ArgoCD)
```

## 🌩️ Cloud Platforms

### GCP (Google Cloud Platform)

**Active Infrastructure:**
- **GKE Cluster**: `dev-cluster` (us-west2-a)
- **ArgoCD**: GitOps deployment platform
- **Kong API Gateway**: Ingress controller (DB-less mode)

**Deploy GCP Infrastructure:**
```bash
cd gcp/org
terraform init && terraform apply

cd ../projects/dev
terraform init && terraform apply
```

**Deployed Applications:** See [k8s-apps repo](https://github.com/andywatts/k8s-apps)

### AWS

**Available Examples:**
- **ECS**: Container orchestration with CDK
- **Lambda**: Serverless functions with SAM/CDK
- **Step Functions**: Workflow orchestration
- **EventBridge**: Event-driven architectures

**Deploy AWS Infrastructure:**
```bash
# CDK projects
cd aws/cdk/aws-cdk-ecs
pip install -r requirements.txt
cdk deploy

# SAM projects
cd aws/lambda-sam/sam-full-stack
sam build && sam deploy --guided
```

## 🚀 Quick Links

- **k8s-apps Repository**: https://github.com/andywatts/k8s-apps
- **GCP Console**: https://console.cloud.google.com/
- **AWS Console**: https://console.aws.amazon.com/

## 📋 Prerequisites

**GCP:**
```bash
# Install gcloud CLI
brew install google-cloud-sdk

# Login
gcloud auth login
gcloud auth application-default login

# Set project
gcloud config set project development-690488
```

**AWS:**
```bash
# Install AWS CLI
brew install awscli

# Install CDK
npm install -g aws-cdk

# Install SAM CLI
brew tap aws/tap
brew install aws-sam-cli

# Configure credentials
aws configure
```

**Common Tools:**
```bash
# Terraform
brew install terraform

# kubectl
brew install kubectl

# Helm
brew install helm
```

## 🎯 Current Active Infrastructure

| Resource | Cloud | Region | Status | Purpose |
|----------|-------|--------|--------|---------|
| GKE dev-cluster | GCP | us-west2-a | ✅ Active | Kubernetes cluster |
| ArgoCD | GCP | us-west2-a | ✅ Active | GitOps platform |
| Kong Gateway | GCP | us-west2-a | ✅ Active | API Gateway |

**Cost:** ~$34/month (dev environment)

## 📖 Documentation

### GCP
- [gcp/README.md](./gcp/README.md) - Terraform workflow
- [k8s-apps](https://github.com/andywatts/k8s-apps) - Kubernetes applications

### AWS
Each CDK/SAM project has its own README with:
- Architecture diagrams
- Deployment instructions
- Configuration options
- Cost estimates

## 🔐 Security

**Never commit:**
- Private keys (*.key, *.pem)
- Service account credentials (*-key.json)
- Terraform state files (*.tfstate)
- AWS access keys
- Environment variables with secrets

All repos have `.gitignore` configured to prevent accidental commits.

## 🛠️ Maintenance

**Terraform State:**
- GCP state is stored locally (consider migrating to GCS backend)
- Run `terraform plan` before applying changes
- Use workspaces for environment separation

**Kubernetes Updates:**
- Applications deploy via ArgoCD (GitOps)
- Push to main branch → auto-sync
- Manual sync: `kubectl apply -f applicationset-dev.yaml`

**Cost Monitoring:**
```bash
# GCP current month costs
gcloud billing accounts list
gcloud alpha billing accounts describe ACCOUNT_ID

# AWS cost explorer
aws ce get-cost-and-usage --time-period Start=2024-01-01,End=2024-01-31 \
  --granularity MONTHLY --metrics BlendedCost
```

## 🧹 Cleanup

**GCP:**
```bash
# Destroy dev infrastructure (careful!)
cd gcp/projects/dev
terraform destroy

# Delete cluster directly
gcloud container clusters delete dev-cluster --zone=us-west2-a
```

**AWS:**
```bash
# CDK
cdk destroy

# SAM
sam delete --stack-name <stack-name>
```

## 📞 Support

For issues or questions:
1. Check project-specific READMEs
2. Review cloud provider documentation
3. Check Terraform/CDK/SAM documentation

---
**Infrastructure as Code:** Version control everything, automate deployment, document changes.


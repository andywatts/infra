# Infrastructure

Infrastructure as Code for Google Cloud Platform using Terraform.

## 🏗️ Structure

```
gcp/
  org/                 # GCP organization & project creation
    main.tf           # Creates development project
    locals.tf         # Region and billing config
  projects/
    dev/               # Dev environment resources
      project.tf       # Project-level config
      gke.tf          # GKE cluster
      argocd-bootstrap.tf  # ArgoCD installation
```

## 🚀 Quick Start

### Prerequisites

```bash
# Install gcloud CLI
brew install google-cloud-sdk

# Login and set up auth
gcloud auth login
gcloud auth application-default login

# Install Terraform
brew install terraform

# Install kubectl & Helm
brew install kubectl helm
```

### Deploy Infrastructure

```bash
# 1. Create GCP project
cd gcp/org
terraform init
terraform plan
terraform apply

# 2. Deploy GKE cluster and ArgoCD
cd ../projects/dev
terraform init
terraform plan
terraform apply
```

This creates:
- ✅ GCP project: `development-690488`
- ✅ GKE cluster: `dev-cluster` (us-west2-a)
- ✅ ArgoCD: GitOps deployment platform
- ✅ Node pool: 1x e2-small node

## 🎯 Current Infrastructure

| Resource | Location | Status | Purpose |
|----------|----------|--------|---------|
| GKE dev-cluster | us-west2-a | ✅ Active | Kubernetes cluster |
| ArgoCD | us-west2-a | ✅ Active | GitOps platform |
| Kong Gateway | us-west2-a | ✅ Active | API Gateway |

**Monthly Cost:** ~$34 (1 e2-small node + LoadBalancer)

## 🌐 Applications

Applications are deployed via ArgoCD from the [k8s-apps repository](https://github.com/andywatts/k8s-apps).

```bash
# Connect to cluster
gcloud container clusters get-credentials dev-cluster \
  --zone=us-west2-a --project=development-690488

# View deployed apps
kubectl get applications -n argocd
```

**Deployed Apps:**
- **sample-app**: Example nginx application
- **kong**: API Gateway with Ingress Controller

## 🔧 Configuration

### GCP Project Settings

Edit `gcp/org/locals.tf`:
```hcl
locals {
  project_id     = "development-690488"
  billing_account = "YOUR_BILLING_ACCOUNT_ID"
  region         = "us-west2"
}
```

### GKE Cluster Settings

Edit `gcp/projects/dev/gke.tf`:
```hcl
resource "google_container_node_pool" "primary" {
  node_count = 1  # Adjust as needed
  
  node_config {
    machine_type = "e2-small"  # Scale up for production
    disk_size_gb = 20
  }
}
```

## 🛠️ Management

### Connect to Cluster

```bash
gcloud container clusters get-credentials dev-cluster \
  --zone=us-west2-a --project=development-690488
```

### View Resources

```bash
# Cluster info
kubectl cluster-info
kubectl get nodes

# Pods across all namespaces
kubectl get pods -A

# ArgoCD applications
kubectl get applications -n argocd
```

### Update Infrastructure

```bash
cd gcp/projects/dev
terraform plan
terraform apply
```

### Scaling

```bash
# Scale node pool
gcloud container clusters resize dev-cluster \
  --num-nodes=2 \
  --zone=us-west2-a
```

## 📊 Cost Optimization

**Current Setup (Dev):**
- 1x e2-small node: ~$13/month
- LoadBalancer: ~$18/month
- External IP: ~$3/month
- **Total: ~$34/month**

**Tips:**
- Use `e2-micro` for minimal dev ($6/month)
- Delete LoadBalancer when not in use
- Use preemptible nodes (save 80%)
- Schedule cluster shutdown during off-hours

## 🔐 Security

### What's Ignored

`.gitignore` prevents committing:
- Terraform state files (`*.tfstate`)
- Service account keys (`*-key.json`)
- Credentials and secrets
- Private keys (`*.key`, `*.pem`)

### Best Practices

1. **Never commit secrets** to Git
2. **Use Workload Identity** instead of service account keys
3. **Enable Binary Authorization** for production
4. **Store Terraform state** in GCS backend (not local)
5. **Use separate projects** for dev/staging/prod

## 📚 Terraform State

**Current:** Local state files (not committed to Git)

**Recommended for Production:**

```hcl
# In projects/dev/backend.tf
terraform {
  backend "gcs" {
    bucket = "your-terraform-state"
    prefix = "dev"
  }
}
```

## 🧹 Cleanup

**Destroy everything (careful!):**

```bash
# Destroy dev resources
cd gcp/projects/dev
terraform destroy

# Destroy project (if needed)
cd ../../org
terraform destroy
```

**Or manually:**

```bash
# Delete GKE cluster
gcloud container clusters delete dev-cluster \
  --zone=us-west2-a --quiet

# Delete project
gcloud projects delete development-690488 --quiet
```

## 📖 Related Documentation

- **k8s-apps**: https://github.com/andywatts/k8s-apps
- **GCP Terraform**: https://registry.terraform.io/providers/hashicorp/google
- **GKE Documentation**: https://cloud.google.com/kubernetes-engine/docs
- **Terraform Best Practices**: https://www.terraform.io/docs/cloud/guides/recommended-practices

## 🎓 Next Steps

- [ ] Deploy Kong API Gateway from k8s-apps
- [ ] Configure custom domain with Cloud DNS
- [ ] Set up Cloud Monitoring & Logging
- [ ] Add staging environment
- [ ] Migrate Terraform state to GCS backend
- [ ] Enable GKE Autopilot for easier management
- [ ] Set up CI/CD pipeline with Cloud Build

---
**Infrastructure as Code:** Declare infrastructure, version control it, deploy repeatably.

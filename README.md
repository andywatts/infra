# Infrastructure

Terraform infrastructure for GKE on Google Cloud Platform.

## Structure

```
gcp/
  org/                 # Project creation
  projects/dev/        # Dev cluster (us-west2, regional)
    gke.tf            # Regional GKE cluster
    argocd-bootstrap.tf  # ArgoCD via Helm
```

## Deploy

```bash
# Install tools
brew install google-cloud-sdk terraform

# Authenticate
gcloud auth login
gcloud auth application-default login

# Deploy infrastructure
cd gcp/org && terraform init && terraform apply
cd ../projects/dev && terraform init && terraform apply
```

## Connect to Cluster

```bash
gcloud container clusters get-credentials dev-cluster \
  --region=us-west2 --project=development-690488

kubectl get nodes  # Should show 3 nodes (one per zone: a, b, c)
```

## Current Infrastructure

| Resource | Location | Status |
|----------|----------|--------|
| GKE dev-cluster | us-west2 (regional) | ✅ 3 nodes across 3 zones |
| ArgoCD | us-west2 | ✅ GitOps platform |
| Kong Gateway | us-west2 | ✅ API Gateway |

**Cost:** ~$40/month (3x e2-small nodes + LoadBalancer)

## Applications

Managed via ArgoCD from [k8s-apps](https://github.com/andywatts/k8s-apps):
- **sample-app**: Nginx example
- **kong**: API Gateway with Ingress Controller

## Configuration

Edit `gcp/projects/dev/locals.tf`:
```hcl
locals {
  region = "us-west2"  # Regional cluster spans all zones
}
```

## Useful Commands

```bash
# View all resources
kubectl get all -A

# ArgoCD applications
kubectl get applications -n argocd

# Scale cluster
gcloud container clusters resize dev-cluster --num-nodes=2 --region=us-west2

# Update infrastructure
cd gcp/projects/dev && terraform apply
```

## Links

- [k8s-apps repository](https://github.com/andywatts/k8s-apps)
- [GCP Console](https://console.cloud.google.com/)

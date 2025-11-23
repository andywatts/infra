# Infrastructure

Terraform infrastructure for GKE on Google Cloud Platform.

## Structure

```
gcp/
  org/                 # Project creation
  projects/dev/        # Dev cluster (us-west2, regional)
    gke.tf            # GKE cluster
    argocd-bootstrap.tf
```

## Deploy

```bash
# Install tools
brew install google-cloud-sdk terraform kubectl helm

# Authenticate
gcloud auth login
gcloud auth application-default login

# Deploy
cd gcp/org && terraform init && terraform apply
cd ../projects/dev && terraform init && terraform apply
```

## Connect to Cluster

```bash
gcloud container clusters get-credentials dev-cluster \
  --region=us-west2 --project=development-690488

kubectl get nodes
kubectl get applications -n argocd
```

## Current Resources

| Resource | Location | Cost/mo |
|----------|----------|---------|
| GKE dev-cluster | us-west2 (regional) | ~$13 |
| LoadBalancer | us-west2 | ~$18 |
| External IP | us-west2 | ~$3 |
| **Total** | | **~$34** |

**Node:** 1x e2-small (2 vCPU, 2GB RAM)

## Applications

Deployed via ArgoCD from [k8s-apps](https://github.com/andywatts/k8s-apps):
- **sample-app**: Example nginx
- **kong**: API Gateway

## Configuration

Edit region in `gcp/projects/dev/locals.tf`:
```hcl
locals {
  region = "us-west2"  # Regional cluster spans all zones
}
```

Scale nodes in `gcp/projects/dev/gke.tf`:
```hcl
resource "google_container_node_pool" "primary" {
  node_count = 1  # Change here
}
```

## Useful Commands

```bash
# View resources
kubectl get pods -A
kubectl get svc -A

# Scale cluster (per zone in regional cluster)
gcloud container clusters resize dev-cluster --num-nodes=2 --region=us-west2

# Update infrastructure
cd gcp/projects/dev && terraform plan && terraform apply
```

## Links

- [k8s-apps repository](https://github.com/andywatts/k8s-apps)
- [GCP Console](https://console.cloud.google.com/)

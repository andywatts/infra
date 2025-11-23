# GCP Terraform

Infrastructure as Code for Google Cloud Platform.

## Structure

```
org/              # Creates GCP projects
  main.tf         # Project creation
  locals.tf       # Region (us-west2), billing config
projects/dev/     # Dev environment resources
  gke.tf          # GKE regional cluster
  argocd-bootstrap.tf  # ArgoCD installation
```

## Workflow

```bash
gcloud auth application-default login

# 1. Create projects
cd org && terraform init && terraform apply

# 2. Manage project resources (GKE cluster)
cd ../projects/dev && terraform init && terraform apply
```

**Region:** us-west2 (Los Angeles)  
**Type:** Regional cluster (spans all zones: a, b, c)


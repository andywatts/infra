# GCP Terraform

## Structure

```
org/              # Creates projects
projects/dev/     # Manages dev project resources
```

## Workflow

```bash
gcloud auth application-default login

# 1. Create projects
cd org && terraform init && terraform apply

# 2. Manage project resources
cd ../projects/dev && terraform init && terraform apply
```


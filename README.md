# Photo Gallery App (GCP + Terraform)

A minimal full-stack photo gallery application deployed to Google Cloud Platform using Terraform. Users can register, log in, and upload/download photos securely.

---

## Architecture

```
┌────────────────────────────┐
│   Terraform (IaC)          │
│   └─ VPC & Subnet          │
│   └─ Cloud SQL (MySQL)     │
│   └─ Compute Engine (VM)   │
│   └─ Firewall Rules        │
└────────────┬──────────────┘
             │
        ┌────▼────┐
        │  VM     │ (e2-standard-2)
        │ Node.js │
        │ Express │
        └────┬────┘
             │
             ▼
       Cloud SQL (private IP)
       └─ MySQL 8 instance
```

---

## Setup Instructions

### 1. Prerequisites

- Node.js and npm installed locally
- Google Cloud SDK installed
- Terraform CLI installed

---

### 2. GCP Setup

```bash
gcloud auth login
gcloud config set project final-459700
gcloud services enable compute.googleapis.com sqladmin.googleapis.com servicenetworking.googleapis.com
```

Create a GCS bucket for remote state:

```bash
gsutil mb -l us-central1 gs://photo-gallery-tf-[YOUR_ID]
gsutil versioning set on gs://photo-gallery-tf-[YOUR_ID]
```
---

### 3. Deploy with Terraform

```bash
cd terraform
terraform init
terraform apply -var="project_id=final-459700" -var="db_password=ethanpassword"
```

Visit the public IP of your VM in the browser to use the application.

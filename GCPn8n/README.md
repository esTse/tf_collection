# Terraform project to deploy n8n on GCP

This Terraform project deploys a n8n instance on a GCP Compute Engine VM using Docker.

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) installed (version ~> 1.0)
- [gcloud CLI](https://cloud.google.com/sdk/gcloud) installed and configured
- A GCP project with billing enabled. The Compute Engine API will be enabled automatically by Terraform if not already enabled.

## Configuration

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/esTse/tf_collection.git
    cd tf_collection/GCPn8n
    ```

2.  **Create a `terraform.tfvars` file:**
    Create a file named `terraform.tfvars` in the project root to define your sensitive or environment-specific variables.
    
    Example `terraform.tfvars`:
    ```hcl
    project_id         = "your-gcp-project-id"
    region             = "us-central1"
    zone               = "us-central1-a"
    n8n_encryption_key = "your-secure-encryption-key" # Generate a strong random string
    ```

    **Variables:**
    *   `project_id`: Your Google Cloud Project ID.
    *   `region`: The GCP region to deploy to (default: us-central1).
    *   `zone`: The GCP zone to deploy to (default: us-central1-a).
    *   `n8n_encryption_key`: A secret key used by n8n to encrypt credentials.
    *   `machine_type`: The machine type for the VM (default: e2-medium).
    *   `disk_size`: Size of the boot disk in GB (default: 20).
    *   `n8n_port`: Port to expose n8n on (default: 5678).

## Deployment

1.  **Initialize Terraform:**
    ```bash
    terraform init
    ```

2.  **Apply the configuration:**
    ```bash
    terraform apply
    ```
    Type `yes` when prompted to confirm the deployment.

## Accessing n8n

Once the deployment is complete, Terraform will likely output the instance details if outputs are configured, or you can find the external IP in the GCP Console.

Access n8n in your browser at:
`http://<EXTERNAL_IP>:<PORT>`

The startup script handles the installation of Docker and n8n. It might take a few minutes after the VM is created for the service to be fully up and running.

## Infrastructure Details

*   **Compute Engine:** Creates an Ubuntu 22.04 LTS VM.
*   **Docker:** Installs Docker and runs n8n in a container.
*   **Networking:** Configures a firewall rule (`n8n-allow-http`) to allow TCP traffic on <PORT> from any source (`0.0.0.0/0`).
*   **Persistence:** A Docker volume `n8n_data` is created to persist n8n data.

## Maintenance

To destroy the infrastructure:
```bash
terraform destroy
```

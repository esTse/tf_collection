# GCP Debian Node.js Server

This Terraform configuration deploys a Debian VM on Google Cloud Platform with Node.js and ncat installed. It also opens port 1808 in the firewall.

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) installed
- [Google Cloud SDK](https://cloud.google.com/sdk/docs/install) installed and authenticated
- A GCP Project

## Configuration

Update `terraform.tfvars` with your `project_id`. You can also customize `region`, `zone`, `machine_type`, `disk_size`, and `allowed_port`.

## Usage

1.  Initialize Terraform:
    ```bash
    terraform init
    ```

2.  Preview the plan:
    ```bash
    terraform plan
    ```

3.  Apply the configuration:
    ```bash
    terraform apply
    ```

4.  The output will display the public IP of the instance.

## Installed Software

- Debian 12 (Bookworm)
- Node.js (Latest from repository)
- ncat (via nmap or ncat package)

## Firewall

- Port 1808 is open to 0.0.0.0/0 (TCP)

# Windows Server 2022 - Local Privilege Escalation Lab

This Terraform project deploys a Windows Server 2022 Virtual Machine on Google Cloud Platform (GCP), pre-configured to serve as a baseline environment for **Local Privilege Escalation (LPE)** testing and research.

## Overview

The environment is designed to be ready-to-use immediately after deployment, with necessary tools installed and users configured. It simulates a scenario with both administrative and low-privileged access.

### Features

- **OS**: Windows Server 2022 (Datacenter Edition)
- **Machine Type**: `e2-standard-8` (8 vCPUs, 32GB RAM) - High performance for heavy workloads.
- **Disk**: 100GB SSD.
- **Pre-installed Tools**:
    - [Chocolatey](https://chocolatey.org/) (Package Manager)
    - Python 3.12
    - Git
    - VS Code
- **Security Configuration**:
    - **Password Complexity Disabled**: To allow simple passwords for testing purposes.
    - **RDP Enabled**: For all configured users.

## User Configuration

The deployment automatically creates and configures two users accessible via RDP:

1.  **`Administrator`**:
    - **Role**: Administrator
    - **Description**: Full administrative access to the system.
    - **Password**: Configured via `terraform.tfvars`.

2.  **`attacker`**:
    - **Role**: Standard User (Non-Privileged)
    - **Description**: A low-privileged account intended to be the starting point for privilege escalation attacks.
    - **Password**: Configured via `terraform.tfvars`.

## Usage

1.  **Configure Credentials**:
    Update the `terraform.tfvars` file with your project ID and desired credentials.
    ```hcl
    project_id        = "your-project-id"
    admin_password    = "your-admin-password"
    attacker_password = "your-attacker-password"
    ```

2.  **Initialize Terraform**:
    ```bash
    terraform init
    ```

3.  **Deploy**:
    ```bash
    terraform apply
    ```

4.  **Connect**:
    After deployment, Terraform will output the **Public IP** and the **User Credentials**. Connect using any RDP client (e.g., Remote Desktop Connection, Remmina).

## Disclaimer

**Security Warning**: This environment deliberately weakens some security settings (e.g., disabling password complexity) for educational and testing purposes. **Do not expose RDP to the open internet without proper firewall rules** (e.g., restricting source IP) in a production or sensitive environment.

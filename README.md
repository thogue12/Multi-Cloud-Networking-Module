# Multi-Cloud-Networking-Module

A **modular, reusable Terraform library** for building secure and scalable **multi-cloud networking architectures** across AWS and Azure. This project is your all-in-one solution for provisioning everything from VPC/VNet peering to complex hybrid-cloud topologies using Transit Gateways, Azure Virtual WAN, and Site-to-Site VPN.

## 🌐 Project Goals

- Enable engineers to deploy multi-cloud network infrastructure through simple and composable Terraform modules.
- Provide reusable patterns for cloud-to-cloud and intra-cloud connectivity.
- Enforce security and compliance with integrated DevSecOps pipelines using GitHub Actions.

---

## 🧱 Modules Included

### 🔁 Peering Modules

- **AWS VPC Peering**
  - Single-region
  - Multi-region
  - Multi-VPC mesh
- **Azure VNet Peering**
  - Single-region
  - Cross-region

### 🌍 Hub-and-Spoke / Transit

- **AWS Transit Gateway**
  - Attach multiple VPCs to a central TGW

- **Azure Virtual WAN**
  - Build scalable hub-and-spoke topologies
- **Cross-cloud Interconnect (Planned)**
  - TGW ↔ VWAN via VPN

### 🔒 VPN Modules

- **AWS ↔ Azure Site-to-Site VPN**
- **Multi-VPC VPN + BGP Routing (Planned)**

---


Each environment maintains **isolated state files**, enabling safe, separate deployments to `dev`, `test`, and `prod`.

---

## ⚙️ CI/CD & DevSecOps

### GitHub Actions Workflow

This repo includes a **dynamic GitHub Actions pipeline** that:

- Validates, formats, and plans Terraform code
- Runs IaC security scans using open-source tools
- Accepts **user input parameters** via workflow dispatch:
  - `environment` (e.g., dev, test, prod)
  - `module_path` (which module to deploy)
  - *(Future)* `cidr_block` and other variables

## DevSecOps Tooling

The workflow enforces high standards through:

- ✅ `terraform fmt`
- ✅ `terraform validate`
- ✅ `terraform plan`
- ✅ `tfsec` (security misconfiguration checks)
- ✅ `tflint` (linting for best practices)
- ✅ `trivy config` (IaC vulnerability scanning)
  
```yaml
on:
  workflow_dispatch:
    inputs:
      environment:
        description: 'Target environment'
        required: true
        default: 'dev'
      module_path:
        description: 'Path to the Terraform module to apply'
        required: true
        default: './modules/aws/vpc-peering'
      cidr_block:
        description: 'Optional CIDR block'
        required: false



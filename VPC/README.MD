# 🧱 AWS VPC Terraform Module

This is a reusable and extensible **Terraform module** for provisioning a secure and scalable **AWS Virtual Private Cloud (VPC)**. It acts as the **foundation** for the AWS side of the [Multi-Cloud-Networking-Module](https://github.com/YOUR_USERNAME/Multi-Cloud-Networking-Module), serving as a core dependency for peering, VPN, and transit gateway modules.

---

## 🎯 Purpose

This module was designed to:

- Standardize AWS VPC creation across environments
- Serve as the **base layer** for multi-cloud connectivity
- Incorporate **intermediate to advanced Terraform patterns** to enable flexibility, composability, and modular reuse
- Continuously evolve as new networking patterns emerge

---

## ⚙️ Features

- VPC creation with configurable CIDR block
- Public, private, and database subnets with NAT gateway support
- Route table management and IGW/NAT configuration
- Optional VPC endpoints and DNS support
- Flexible subnet grouping via dynamic blocks
- Use of **locals**, **count**, **conditional logic**, and **dynamic blocks**

---

## 🧠 Terraform Concepts Used

This module demonstrates intermediate to advanced usage of:

- `count` and `for_each` for resource control
- `locals` for centralized logic and derived values
- `dynamic` blocks for on-demand subnet generation
- Conditional logic inside locals for flexible configurations
- Parameterized design for reuse across environments (`dev`, `test`, `prod`)

---




# VIBE — Vault + Istio + Bedrock on EKS

![CI](https://github.com/DouglasFriedmann/vault-istio-bedrock-eks/actions/workflows/ci.yaml/badge.svg)
![CodeQL](https://github.com/DouglasFriedmann/vault-istio-bedrock-eks/actions/workflows/codeql.yml/badge.svg)
![Dependabot](https://img.shields.io/badge/dependabot-enabled-brightgreen?logo=dependabot)

VIBE is a modern cloud-native AI platform project built on Amazon EKS using Terraform, Istio service mesh, Argo Rollouts progressive delivery, HashiCorp Vault secret injection, and Amazon Bedrock.

## Core Stack

* Terraform
* Amazon EKS
* Amazon Bedrock
* IRSA (IAM Roles for Service Accounts)
* Istio Service Mesh
* mTLS
* Argo Rollouts
* HashiCorp Vault
* Prometheus + Grafana
* GitHub Actions CI
* CodeQL
* Dependabot

## Highlights

* Provisioned AWS infrastructure with Terraform using remote state in S3 + DynamoDB locking
* Built a FastAPI AI application integrated with Amazon Bedrock
* Implemented IRSA for secure pod-to-AWS authentication without static credentials
* Installed Istio with sidecar injection and enforced mTLS within the application namespace
* Implemented progressive delivery using Argo Rollouts with Istio traffic routing
* Injected runtime configuration securely using HashiCorp Vault Agent Injector
* Added Prometheus metrics instrumentation with Grafana observability dashboards
* Created GitHub Actions CI pipelines for Terraform validation, linting, Docker builds, and CodeQL scanning

## Architecture

```text
Terraform
  └── EKS
        ├── Istio Service Mesh
        │     ├── mTLS
        │     └── Argo Rollouts
        │
        ├── Vault Agent Injection
        │
        ├── IRSA → Amazon Bedrock
        │
        └── Prometheus + Grafana
```

## Current Status

* End-to-end Bedrock connectivity working from EKS pods
* Istio sidecar injection operational
* mTLS enabled in namespace
* Argo Rollouts canary deployments functional
* Vault secret injection functional
* Metrics exposed and scraped by Prometheus
* Grafana dashboards operational


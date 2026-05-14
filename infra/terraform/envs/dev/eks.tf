module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = "vibe-eks"
  cluster_version = "1.33"

  cluster_endpoint_public_access = true

  enable_cluster_creator_admin_permissions = true

  vpc_id = module.vpc.vpc_id

  subnet_ids = module.vpc.private_subnets

  eks_managed_node_groups = {
    default = {
      instance_types = ["t3.large"]

      min_size     = 1
      max_size     = 3
      desired_size = 2

      ami_type = "AL2023_x86_64_STANDARD"

      capacity_type = "ON_DEMAND"
    }
  }

  tags = {
    Project = "vault-istio-bedrock-eks"
  }

  node_security_group_additional_rules = {
  ingress_cluster_istio_webhook = {
    description                   = "Allow EKS control plane to reach Istio webhook"
    protocol                      = "tcp"
    from_port                     = 15017
    to_port                       = 15017
    type                          = "ingress"
    source_cluster_security_group = true
    }
  }
}


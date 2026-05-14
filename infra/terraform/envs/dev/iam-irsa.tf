data "aws_iam_policy_document" "vibe_bedrock" {
  statement {
    effect = "Allow"

    actions = [
      "bedrock:InvokeModel",
      "bedrock:InvokeModelWithResponseStream"
    ]

    resources = ["*"]
  }
}

module "vibe_app_irsa" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "~> 5.0"

  role_name = "vibe-app-bedrock-irsa"

  role_policy_arns = {
    bedrock = aws_iam_policy.vibe_bedrock.arn
  }

  oidc_providers = {
    main = {
      provider_arn               = module.eks.oidc_provider_arn
      namespace_service_accounts = ["vibe:vibe-app"]
    }
  }

  tags = {
    Project = "vault-istio-bedrock-eks"
  }
}

resource "aws_iam_policy" "vibe_bedrock" {
  name        = "vibe-app-bedrock-policy"
  description = "Allow VIBE app to invoke Amazon Bedrock models"
  policy      = data.aws_iam_policy_document.vibe_bedrock.json

  tags = {
    Project = "vault-istio-bedrock-eks"
  }
}

output "vibe_app_irsa_role_arn" {
  value = module.vibe_app_irsa.iam_role_arn
}

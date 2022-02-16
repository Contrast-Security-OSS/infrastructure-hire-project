#############################################
# Create an IAM role to be assumed with OIDC
#############################################
# module "iam_assumable_role_s3" {
#   source                        = "terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc"
#   create_role                   = true
#   role_name                     = "contrast-example-s3"
#   provider_url                  = replace(module.eks.cluster_oidc_issuer_url, "https://", "")
#   role_policy_arns              = [<policy>]
#   oidc_fully_qualified_subjects = ["system:serviceaccount:${local.k8s_service_account_namespace}:${local.k8s_service_account_name}"]
# }

##############################
# Create an IAM policy here
##############################

resource "aws_iam_policy" "bucket_policy" {
  name        = "my-bucket-policy"
  path        = "/"
  description = "Allow "
  policy = jsonencode ({
  "Version" : "2012-10-17",
  "Statement" : [
    {
      "Sid" : "S3",
      "Effect" : "Allow",
      "Action" : [
        "s3:PutObject",
        "s3:GetObject",
        "s3:ListBucket",
        "s3:DeleteObject"
      ],
      "Resource" : [
        "arn:aws:s3:::*/*",
        "arn:aws:s3:::vancouver-canada"
      ]
    }
  ]
})
}


####################################
# Define an IAM policy document here
####################################

# data "aws_iam_policy_document" "s3" {
# }

/*
data "aws_iam_policy_document" "service_account_assume_role" {
  statement {
    principals {
      type = "Federated"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/${local.oidc_issuer_domain}"]
    }
    actions = [
      "sts:AssumeRoleWithWebIdentity"
    ]
    condition {
      test     = "StringEquals"
      variable = "${local.oidc_issuer_domain}:sub"

      values = [
        "system:serviceaccount:${var.namespace}:${var.name}"
      ]
    }
  }
}

resource "aws_iam_role" "role" {
  name = local.role_name
  force_detach_policies = true
  assume_role_policy = data.aws_iam_policy_document.service_account_assume_role.json
  tags = var.role_tags
}

resource "kubernetes_service_account" "service_account" {
  metadata {
    name = var.name
    namespace = var.namespace
    annotations = {
      "eks.amazonaws.com/role-arn" = aws_iam_role.role.arn
    }
  }
  automount_service_account_token = var.automount_service_account_token
}
*/
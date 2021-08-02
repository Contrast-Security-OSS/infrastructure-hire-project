#############################################
# Create an IAM role to be assumed with OIDC
#############################################

# module "iam_assumable_role_s3" {
#   source                        = "terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc"
#   version                       = "~> v2.6.0"
#   create_role                   = true
#   role_name                     = "contrast-example-s3"
#   provider_url                  = replace(module.eks.cluster_oidc_issuer_url, "https://", "")
#   role_policy_arns              = [aws_iam_policy.s3.arn]
#   oidc_fully_qualified_subjects = ["system:serviceaccount:${local.k8s_service_account_namespace}:${local.k8s_service_account_name}"]
# }

##############################
# Create an IAM policy here
##############################

# resource "aws_iam_policy" "s3" {
# }

####################################
# Define an IAM policy document here
####################################

# data "aws_iam_policy_document" "s3" {
# }

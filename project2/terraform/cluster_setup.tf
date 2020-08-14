###########
# Uncomment this to create a service account to be used with a Kubernetes resource
###########
resource "kubernetes_service_account" "s3" {
  metadata {
    name      = local.k8s_service_account_name
    namespace = local.k8s_service_account_namespace
    annotations = {
      "eks.amazonaws.com/role-arn" = module.iam_assumable_role_s3.this_iam_role_arn
    }
  }
  automount_service_account_token = true
}

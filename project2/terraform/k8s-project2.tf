##############################################################
#  project2 kubernetes resources
##############################################################
# authenticate to eks cluster
resource "null_resource" "update_config_map_aws_auth" {
  depends_on = [module.eks]

  provisioner "local-exec" {
    command = "aws eks update-kubeconfig --name ${local.cluster_name}"
  }
}

# pod
resource "kubernetes_pod" "vulnerability_report" {
  metadata {
    name      = "${var.project}-vulnerability-report"
    namespace = local.k8s_service_account_namespace

    annotations = {
      "iam.amazonaws.com/role" = module.iam_assumable_role_s3.this_iam_role_arn
    }
  }

  spec {
    service_account_name = local.k8s_service_account_name
    automount_service_account_token = true
    container {
      image = "${aws_ecr_repository.vulnerability_reporting.repository_url}:${var.image_version}"
      name  = "vulnerability-report"

      env {
        name  = "bucket"
        value = aws_s3_bucket.vulnerability_reporting.id
      }

      env {
        name  = "kms_key_id"
        value = aws_kms_key.infra.key_id
      }
    }
  }
}

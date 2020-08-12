##############################################################
#  project2 kubernetes resources
##############################################################
# authenticate to eks cluster
resource "null_resource" "update_config_map_aws_auth" {
  depends_on = [module.eks]

  provisioner "local-exec" {
    command = "aws eks update-kubeconfig --name contrast-example"
  }
}

# namespace
resource "kubernetes_namespace" "project2" {
  metadata {
    name = var.project
  }
}

# pod
resource "kubernetes_pod" "vulnerability_report" {
  metadata {
    name      = "${var.project}-vulnerability-report"
    # annotations = ADD A ROLE HERE
    namespace = var.project
  }

  spec {
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

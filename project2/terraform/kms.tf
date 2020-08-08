##############################################################
#  Infra Key
##############################################################
resource "aws_kms_key" "infra" {
  description             = "${var.project} infrastructure encryption key"
  deletion_window_in_days = 10

  tags = {
    name      = "${var.project}-infra"
    project   = var.project
    terraform = "true"
    env       = var.env
  }
}

resource "aws_kms_alias" "infra" {
  name          = "alias/${var.project}-infra"
  target_key_id = aws_kms_key.infra.key_id
}

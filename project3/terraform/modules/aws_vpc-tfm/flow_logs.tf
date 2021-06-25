data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

resource "aws_cloudwatch_log_group" "flow_logs" {
  name              = "/aws/vpc/${var.name}-vpc-logs"
  retention_in_days = var.sumo_ingest_environment != "" ? 7 : 30
  tags              = var.tags
}

resource "aws_iam_role" "flow_logs" {
  name_prefix = "${var.name}-fl-"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "vpc-flow-logs.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  tags               = var.tags
}

data "aws_iam_policy_document" "flow_logs" {
  statement {
    sid = "AllowToLog"

    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams"
    ]

    resources = [
      "${aws_cloudwatch_log_group.flow_logs.arn}:*"
    ]
  }
}

resource "aws_iam_role_policy" "flow_logs" {
  name_prefix = "${var.name}-fl-"
  role        = aws_iam_role.flow_logs.id
  policy      = data.aws_iam_policy_document.flow_logs.json
}

resource "aws_flow_log" "this" {
  count           = var.sumo_ingest_environment != "" ? 1 : 0
  iam_role_arn    = aws_iam_role.flow_logs.arn
  log_destination = aws_cloudwatch_log_group.flow_logs.arn
  traffic_type    = "ALL"
  vpc_id          = concat(aws_vpc.this.*.id, [""])[0]
  tags            = var.tags
}

resource "aws_cloudwatch_log_subscription_filter" "flow_logs" {
  count           = var.sumo_ingest_environment != "" ? 1 : 0
  name            = "${var.name}-fl"
  log_group_name  = "/aws/vpc/${var.name}-vpc-logs"
  filter_pattern  = ""
  destination_arn = "arn:aws:lambda:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:function:sumo-ingest-${var.sumo_ingest_environment}-${data.aws_region.current.name}"
  depends_on      = [aws_flow_log.this]
}
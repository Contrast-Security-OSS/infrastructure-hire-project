resource "aws_cloudwatch_dashboard" "cloudwatch_dashboard" {
  dashboard_name = "${var.project_name_prefix}-ecs-service"

  dashboard_body = <<EOF
{"widgets":[{"type":"metric","x":12,"y":6,"width":12,"height":6,"properties":{"view":"timeSeries","stacked":false,"metrics":[["AWS/ECS","MemoryUtilization","ServiceName","${var.project_name_prefix}-ecs-service","ClusterName","${var.project_name_prefix}-ecs-service",{"color":"#1f77b4"}],[".","CPUUtilization",".",".",".",".",{"color":"#9467bd"}]],"region":"us-east-1","period":300,"title":"Memory and CPU utilization","yAxis":{"left":{"min":0,"max":100}}}},{"type":"metric","x":0,"y":6,"width":12,"height":6,"properties":{"view":"timeSeries","stacked":true,"metrics":[["AWS/ApplicationELB","HTTPCode_Target_5XX_Count","TargetGroup","${aws_alb_target_group.app.arn_suffix}","LoadBalancer","${aws_alb.main_alb.arn_suffix}",{"period":60,"color":"#d62728","stat":"Sum"}],[".","HTTPCode_Target_4XX_Count",".",".",".",".",{"period":60,"stat":"Sum","color":"#bcbd22"}],[".","HTTPCode_Target_3XX_Count",".",".",".",".",{"period":60,"stat":"Sum","color":"#98df8a"}],[".","HTTPCode_Target_2XX_Count",".",".",".",".",{"period":60,"stat":"Sum","color":"#2ca02c"}]],"region":"us-east-1","title":"Container responses","period":300,"yAxis":{"left":{"min":0}}}},{"type":"metric","x":12,"y":0,"width":12,"height":6,"properties":{"view":"timeSeries","stacked":false,"metrics":[["AWS/ApplicationELB","TargetResponseTime","LoadBalancer","${aws_alb.main_alb.arn_suffix}",{"period":60,"stat":"p50"}],["...",{"period":60,"stat":"p90","color":"#c5b0d5"}],["...",{"period":60,"stat":"p99","color":"#dbdb8d"}]],"region":"us-east-1","period":300,"yAxis":{"left":{"min":0,"max":3}},"title":"Container response times"}},{"type":"metric","x":12,"y":12,"width":12,"height":2,"properties":{"view":"singleValue","metrics":[["AWS/ApplicationELB","HealthyHostCount","TargetGroup","${aws_alb_target_group.app.arn_suffix}","LoadBalancer","${aws_alb.main_alb.arn_suffix}",{"color":"#2ca02c","period":60}],[".","UnHealthyHostCount",".",".",".",".",{"color":"#d62728","period":60}]],"region":"us-east-1","period":300,"stacked":false}},{"type":"metric","x":0,"y":0,"width":12,"height":6,"properties":{"view":"timeSeries","stacked":true,"metrics":[["AWS/ApplicationELB","HTTPCode_Target_5XX_Count","LoadBalancer","${aws_alb.main_alb.arn_suffix}",{"period":60,"stat":"Sum","color":"#d62728"}],[".","HTTPCode_Target_4XX_Count",".",".",{"period":60,"stat":"Sum","color":"#bcbd22"}],[".","HTTPCode_Target_3XX_Count",".",".",{"period":60,"stat":"Sum","color":"#98df8a"}],[".","HTTPCode_Target_2XX_Count",".",".",{"period":60,"stat":"Sum","color":"#2ca02c"}]],"region":"us-east-1","title":"Load balancer responses","period":300,"yAxis":{"left":{"min":0}}}}]}
EOF
}

resource "aws_cloudwatch_metric_alarm" "ecs-alert_High-CPUReservation" {
  alarm_name = "${var.project_name_prefix}-ECS-High_CPUResv"
  comparison_operator = "GreaterThanOrEqualToThreshold"

  period = "60"
  evaluation_periods = "1"
  datapoints_to_alarm = 1

  # second
  statistic = "Average"
  threshold = "10"
  alarm_description = "CPU increases"

  metric_name = "CPUReservation"
  namespace = "AWS/ECS"
  dimensions = {
    ClusterName = aws_ecs_cluster.main.name
  }

  actions_enabled = true
  insufficient_data_actions = []
  ok_actions = []
}

resource "aws_cloudwatch_metric_alarm" "ecs-alert_High-MemReservation" {
  alarm_name = "${var.project_name_prefix}-ECS-High_MemResv"
  comparison_operator = "GreaterThanOrEqualToThreshold"

  period = "60"
  evaluation_periods = "1"
  datapoints_to_alarm = 1

  statistic = "Average"
  threshold = "10"
  alarm_description = "Memory increases"

  metric_name = "MemoryReservation"
  namespace = "AWS/ECS"
  dimensions = {
    ClusterName = aws_ecs_cluster.main.name
  }

  actions_enabled = true
  insufficient_data_actions = []
  ok_actions = []
#   alarm_actions = [
#     "${var.sns_topic_cloudwatch_alarm_arn}",
#     "${aws_autoscaling_policy.ecs-asg_increase.arn}",
#   ]
}
# Store application container logs for 7 days
resource "aws_cloudwatch_log_group" "application" {
  name              = "/aws/containerinsights/${var.cluster_name}/application"
  retention_in_days = 7

  tags = local.common_tags
}

# Store Kubernetes data-plane logs for 7 days
resource "aws_cloudwatch_log_group" "dataplane" {
  name              = "/aws/containerinsights/${var.cluster_name}/dataplane"
  retention_in_days = 7

  tags = local.common_tags
}

# Store worker-node host logs for 7 days
resource "aws_cloudwatch_log_group" "host" {
  name              = "/aws/containerinsights/${var.cluster_name}/host"
  retention_in_days = 7

  tags = local.common_tags
}

# Store EKS control-plane logs for 7 days
resource "aws_cloudwatch_log_group" "eks_control_plane" {
  name              = "/aws/eks/${var.cluster_name}/cluster"
  retention_in_days = 7

  tags = local.common_tags
}

# Count ERROR messages found in the application Pod logs
resource "aws_cloudwatch_log_metric_filter" "application_errors" {
  name           = "${local.name_prefix}-application-errors"
  log_group_name = aws_cloudwatch_log_group.application.name
  pattern        = "{ $.kubernetes.namespace_name = \"aws-eks-platform\" && $.kubernetes.container_name = \"aws-eks-platform-app\" && $.log = \"*ERROR*\" }"

  metric_transformation {
    name      = "ApplicationErrors"
    namespace = "EKSPlatform"
    value     = "1"
  }
}

# Raise an alarm when application errors are detected
resource "aws_cloudwatch_metric_alarm" "application_errors" {
  alarm_name          = "${local.name_prefix}-application-errors"
  alarm_description   = "Application errors detected in the EKS workload logs"
  namespace           = "EKSPlatform"
  metric_name         = "ApplicationErrors"
  statistic           = "Sum"
  period              = 300
  evaluation_periods  = 1
  threshold           = 1
  comparison_operator = "GreaterThanOrEqualToThreshold"
  treat_missing_data  = "notBreaching"

  alarm_actions = [
    aws_sns_topic.alerts.arn
  ]

  tags = local.common_tags
}

# Create an SNS topic for CloudWatch alarm notifications
resource "aws_sns_topic" "alerts" {
  name = "${local.name_prefix}-alerts"

  tags = local.common_tags
}

# Send SNS alerts to the configured email address
resource "aws_sns_topic_subscription" "alerts_email" {
  topic_arn = aws_sns_topic.alerts.arn
  protocol  = "email"
  endpoint  = var.alert_email
}

# Create a CloudWatch dashboard for the EKS platform
resource "aws_cloudwatch_dashboard" "eks_platform" {
  dashboard_name = "${local.name_prefix}-dashboard"

  dashboard_body = jsonencode({
    widgets = [
      {
        type = "metric"

        properties = {
          title  = "Application Errors"
          region = var.aws_region

          metrics = [
            [
              "EKSPlatform",
              "ApplicationErrors"
            ]
          ]

          period = 300
          stat   = "Sum"
          view   = "timeSeries"
        }
      },
      {
        type = "log"

        properties = {
          title  = "Recent Application Logs"
          region = var.aws_region

          query = "SOURCE '${aws_cloudwatch_log_group.application.name}' | fields @timestamp, @message | sort @timestamp desc | limit 50"
        }
      }
    ]
  })
}
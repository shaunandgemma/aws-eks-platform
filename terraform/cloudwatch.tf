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
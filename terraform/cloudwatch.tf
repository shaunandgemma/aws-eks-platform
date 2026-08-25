# Store application container logs for 7 days
resource "aws_cloudwatch_log_group" "application" {
  name              = "/aws/containerinsights/${aws_eks_cluster.main.name}/application"
  retention_in_days = 7

  tags = local.common_tags
}

# Store Kubernetes data-plane logs for 7 days
resource "aws_cloudwatch_log_group" "dataplane" {
  name              = "/aws/containerinsights/${aws_eks_cluster.main.name}/dataplane"
  retention_in_days = 7

  tags = local.common_tags
}

# Store worker-node host logs for 7 days
resource "aws_cloudwatch_log_group" "host" {
  name              = "/aws/containerinsights/${aws_eks_cluster.main.name}/host"
  retention_in_days = 7

  tags = local.common_tags
}
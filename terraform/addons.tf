resource "aws_eks_addon" "pod_identity_agent" {
  cluster_name = aws_eks_cluster.main.name
  addon_name   = "eks-pod-identity-agent"

  tags = local.common_tags
}

resource "aws_eks_pod_identity_association" "vpc_cni" {
  cluster_name    = aws_eks_cluster.main.name
  namespace       = "kube-system"
  service_account = "aws-node"
  role_arn        = aws_iam_role.vpc_cni.arn
}

# Give the AWS Load Balancer Controller Pod its dedicated IAM role
resource "aws_eks_pod_identity_association" "load_balancer_controller" {
  cluster_name    = aws_eks_cluster.main.name
  namespace       = "kube-system"
  service_account = "aws-load-balancer-controller"
  role_arn        = aws_iam_role.load_balancer_controller.arn
}

# Give the Cluster Autoscaler Pod its dedicated IAM role through Pod Identity
resource "aws_eks_pod_identity_association" "cluster_autoscaler" {
  cluster_name    = aws_eks_cluster.main.name
  namespace       = "kube-system"
  service_account = "cluster-autoscaler"
  role_arn        = aws_iam_role.cluster_autoscaler.arn
}

# Give CloudWatch Agent Pods their dedicated IAM role through Pod Identity
resource "aws_eks_pod_identity_association" "cloudwatch_agent" {
  cluster_name    = aws_eks_cluster.main.name
  namespace       = "amazon-cloudwatch"
  service_account = "cloudwatch-agent"
  role_arn        = aws_iam_role.cloudwatch_agent.arn
}

# Install CloudWatch Observability for EKS
resource "aws_eks_addon" "cloudwatch_observability" {
  cluster_name = aws_eks_cluster.main.name
  addon_name   = "amazon-cloudwatch-observability"

  # Keep the first stage focused on Container Insights rather than
  # automatically instrumenting every application for Application Signals
  configuration_values = jsonencode({

    # Use the newer recommended OpenTelemetry Container Insights
    containerInsights = {
      enabled = false
    }

    otelContainerInsights = {
      enabled = true
    }


    manager = {
      applicationSignals = {
        autoMonitor = {
          monitorAllServices = false
        }
      }
    }
  })

  depends_on = [
    aws_eks_addon.pod_identity_agent,
    aws_eks_pod_identity_association.cloudwatch_agent,
    aws_iam_role_policy_attachment.cloudwatch_agent,
    aws_iam_role_policy_attachment.cloudwatch_xray
  ]

  tags = local.common_tags
}
output "cluster_endpoint" {
  description = "EKS cluster endpoint"
  value       = aws_eks_cluster.tec-prod-eks-cluster.endpoint
}

output "cluster_name" {
  description = "EKS cluster name"
  value       = aws_eks_cluster.tec-prod-eks-cluster.name
}

output "node_group_role_arn" {
  description = "IAM role ARN for the node group"
  value       = aws_iam_role.tec_eks_worker_node_grp_role.arn
}

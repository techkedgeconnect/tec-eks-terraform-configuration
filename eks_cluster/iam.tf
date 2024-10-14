# Create eks cluster role - Provides permissions for the Kubernetes control plane
resource "aws_iam_role" "tec_eks_cluster_role" {
  name = "${var.cluster_name}-eks-cluster-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
      }
    ]
  })

  tags = {
    Name = "${var.cluster_name}-eks-cluster-role"
  }
}

# Create eks cluster policy attachment - for required iam policy to the AmazonEKSClusterPolicy
resource "aws_iam_role_policy_attachment" "tec_eks_cluster_role_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.tec_eks_cluster_role.name
}

# Create eks nodes role - grants worker nodes the necessary permissions for interacting with the EKS cluster and accessing resources
resource "aws_iam_role" "tec_eks_worker_node_grp_role" {
  name = "${var.cluster_name}-eks-node-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })

  tags = {
    Name = "${var.cluster_name}-eks-node-role"
  }
}

# Create eks node group policy attachment - for required iam policy to the AmazonEKSWorkerNodePolicy
resource "aws_iam_role_policy_attachment" "tec_eks_worker_node_grp_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.tec_eks_worker_node_grp_role.name
}

# Create eks cni policy attachment - for required iam policy to the AmazonEKSCNIPolicy
resource "aws_iam_role_policy_attachment" "tec_eks_cni_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.tec_eks_worker_node_grp_role.name
}

# Create eks container policy attachment - for required iam policy to the AmazonEC2ContainerRegistryPolicy
resource "aws_iam_role_policy_attachment" "tec_eks_ec2_container_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.tec_eks_worker_node_grp_role.name
}

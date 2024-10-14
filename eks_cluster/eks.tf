# Create the EKS cluster - Configures the Kubernetes control plane and integrates it with the VPC
resource "aws_eks_cluster" "tec-prod-eks-cluster" {
  name     = var.cluster_name
  role_arn = aws_iam_role.tec_eks_cluster_role.arn

  vpc_config {
    subnet_ids = concat(
      module.vpc.public_subnets,
      module.vpc.private_subnets
    )
    security_group_ids = [aws_security_group.tec_eks_cluster_sg.id]
  }



  tags = {
    Name = var.cluster_name
  }
}

# Create Node Group - Defines the worker nodes that will run the Kubernetes workloads
resource "aws_eks_node_group" "tec_eks_worker_node_grp" {
  cluster_name    = aws_eks_cluster.tec-prod-eks-cluster.name
  node_group_name = "${var.cluster_name}-node-group"
  node_role_arn   = aws_iam_role.tec_eks_worker_node_grp_role.arn
  subnet_ids      = module.vpc.private_subnets

  scaling_config {
    desired_size = var.desired_capacity
    max_size     = var.max_capacity
    min_size     = var.min_capacity
  }

  instance_types = [var.node_group_instance_type]

  remote_access {
    ec2_ssh_key               = var.ssh_key_name
    source_security_group_ids = [aws_security_group.tec_eks_node_sg.id]
  }

  tags = {
    Name = "${var.cluster_name}-node-group"
  }
}
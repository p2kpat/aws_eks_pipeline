#this file is used to defin the AWS-EKS service configuration.
#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_cluster
#use the above link to establish more control over the cluster.



resource "aws_eks_cluster" "aws_eks_master" {
  name     = "aws_eks_cluster_service_master"
  role_arn = local.master_role_arn
  vpc_config {
    subnet_ids = [aws_subnet.subnet_a.id, aws_subnet.subnet_b.id, aws_subnet.subnet_c.id]
  }
  tags = {
    Name = "aws_eks_pipeline"
  }
  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.AmazonEKSServicePolicy,
  ]
}


#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_node_group
#use the link above to mange the AWS-EKS node group.

resource "aws_eks_node_group" "worker_node" {
  cluster_name    = aws_eks_cluster.aws_eks_master.name
  node_group_name = "worker_nodes"
  node_role_arn   = local.worker_role_arn
  subnet_ids      = [aws_subnet.subnet_a.id, aws_subnet.subnet_b.id, aws_subnet.subnet_c.id]
  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }

#  update_config {
#    max_unavailable = 1
#  }

  tags = {
    Name = "aws_eks_pipeline"
  }
  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
  ]
}

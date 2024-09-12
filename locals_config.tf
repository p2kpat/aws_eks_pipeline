locals {
  master_role_arn = aws_iam_role.aws_eks_master_node[0].arn
  worker_role_arn = aws_iam_role.aws_eks_worker_node[0].arn
}



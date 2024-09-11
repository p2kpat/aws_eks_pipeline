resource "aws_iam_role" "aws_eks_master_node" {
  name               = "aws_eks_master_node_role"
  assume_role_policy = data.aws_iam_policy_document.master_assume_role_policy.json
}

resource "aws_iam_role" "aws_eks_worker_node" {
  name               = "aws_eks_worker_node_role"
  assume_role_policy = data.aws_iam_policy_document.worker_assume_role_policy.json
}

data "aws_iam_policy_document" "master_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["eks.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "worker_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}


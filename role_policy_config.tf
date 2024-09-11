#create the role polices that will we linked to the IAM service user.
#this allows the user to allow such actions like create an EC2 instance or EKS cluster.
#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role
#the link above provides more details on the AWS_iam_role.

data "aws_iam_role" "existing_master_role" {
  name = "aws_eks_master_node_role"
}

data "aws_iam_role" "existing_worker_role" {
  name = "aws_eks_worker_node_role"
}


# Define IAM roles
resource "aws_iam_role" "aws_eks_master_node" {
  count = (length(data.aws_iam_role.existing_master_role) > 0) ? 0 : 1
  name  = "aws_eks_master_node_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
        Action    = "sts:AssumeRole"
      },
    ]
  })
}

resource "aws_iam_role" "aws_eks_worker_node" {
  count = (length(data.aws_iam_role.existing_worker_role) > 0) ? 0 : 1
  name  = "aws_eks_worker_node_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"  # EC2 service principal
        }
        Action    = "sts:AssumeRole"
      },
      {
        Effect    = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"  # EKS service principal (if needed)
        }
        Action    = "sts:AssumeRole"
      },
    ]
  })
}

# Policy attachments
resource "aws_iam_role_policy_attachment" "AmazonEKSClusterPolicy" {
  count     = var.use_existing_resources ? 0 : 1
  role      = aws_iam_role.aws_eks_master_node[0].name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_iam_role_policy_attachment" "AmazonEKSServicePolicy" {
  count     = var.use_existing_resources ? 0 : 1
  role      = aws_iam_role.aws_eks_master_node[0].name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
}

resource "aws_iam_role_policy_attachment" "AmazonEKSWorkerNodePolicy" {
  count     = var.use_existing_resources ? 0 : 1
  role      = aws_iam_role.aws_eks_worker_node[0].name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

resource "aws_iam_role_policy_attachment" "AmazonEKS_CNI_Policy" {
  count     = var.use_existing_resources ? 0 : 1
  role      = aws_iam_role.aws_eks_worker_node[0].name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryReadOnly" {
  count     = var.use_existing_resources ? 0 : 1
  role      = aws_iam_role.aws_eks_worker_node[0].name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

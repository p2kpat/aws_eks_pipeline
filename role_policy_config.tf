#create the role polices that will we linked to the IAM service user.
#this allows the user to allow such actions like create an EC2 instance or EKS cluster.
#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role
#the link above provides more details on the AWS_iam_role.


#create the policy to allow creation of eks services using the IAM service user.
resource "aws_iam_role" "aws_eks_master_node" {
  name = "master_node_role_policy"
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      Effect    = "Allow",
      Principal = {
        Service = "eks.amazonaws.com"
#        Service = "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY

  tags = {
    name = "aws_eks_pipeline"
  }
}


#create new role to allow creation of EC2 instance use the HAS(horizontal autoscaling).
resource "aws_iam_role" "aws_eks_worker_node" {
  name = "worker_node_role_policy"
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
  tags = {
    name = "aws_eks_pipeline"
  }
}


#Now that the roles are defined we can attach the eks_master role with the policies for EKS Cluster and Service.
resource "aws_iam_role_policy_attachment" "AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.aws_eks_master_node.name
}

resource "aws_iam_role_policy_attachment" "AmazonEKSServicePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = aws_iam_role.aws_eks_master_node.name
}



#Also we can attach the eks_nodes roles with the aws worker policy,AWS_CNI policy, and the aws_ec2_container_registry
resource "aws_iam_role_policy_attachment" "AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.aws_eks_worker_node.name
}

resource "aws_iam_role_policy_attachment" "AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.aws_eks_worker_node.name
}

resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.aws_eks_worker_node.name
}

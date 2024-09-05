### create a virtual private cloud for your EKS cluster to run on.
### use this link  https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc
### note providing the /16 is a medium sized CIDR block
### /1 represent largest cidr block, /32 represent smallest.

resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
#  instance_tenancy = "default"

  tags = {
    Name = "aws_eks_pipeline"
  }
}

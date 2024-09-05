#this will provide the gateway in which the VPC will be able to communicate with the internet.
#the IGW is the INTERNET GATEWAY in which acts like a router in which is required for necessary internet traffic.
#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway
#use the above link for more information on the internetgateway with AWS.


resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "aws_eks_pipeline"
  }
}

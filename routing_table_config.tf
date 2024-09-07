#This file is used to define the routing tables.
#Create a resource of type routing table to route traffic to the internet gateway.
#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table
#use the link above to get more details on the routing table.

resource "aws_route_table" "routing_table" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
#This route is part of example provided on the aws webpage.
#  route {
#    ipv6_cidr_block        = "::/0"
#    egress_only_gateway_id = aws_egress_only_internet_gateway.example.id
#  }
  tags = {
    Name = "aws_eks_pipeline"
  }
}

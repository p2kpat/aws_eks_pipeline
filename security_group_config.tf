#this file is used to define the Security group which handles the Ports for the VPC created or provided.
#use ingress to open the ports for incoming traffic for your aws_configuration.
#use egress for allowing outgoing traffic from the instance.
#use link below to get more details on Security group.
#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group
#When providing the rules for these port it can be unsafe to allow traffic from all sources.

# Define the Security Group
resource "aws_security_group" "k8s_sg" {
  name        = "k8s-sg"
  vpc_id      = aws_vpc.main.id

# Allow outgoing traffic from all sources.
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

# Allow SSH by opening port 22 using ingress to allow incoming traffic from all sources
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

# Allow http by opening port 80 using ingress to allow incoming traffic from sources
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

# Allow https by opening port 443 using ingress to allow incoming traffic from sources
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

# Allow Jenkins communication if using Jenkins or any other applications or service using this port on EC2 instance.
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

# Port 3000 is the default port local development servers use, especially React apps.
# When you create a new React project and run the npm start command,
# The development server typically listens on port 3000 on these React apps.
# this port is used on a wide variety of uses.
  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

# this port also allows http traffic, and can be used as a web proxy port.
   ingress {
    from_port   = 81
    to_port     = 81
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "aws_eks_pipeline"
  }
}


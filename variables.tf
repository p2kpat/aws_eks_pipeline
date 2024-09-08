# AMI ID for the EC2 instances
variable "ami_id" {
  description = "AMI ID"
  type        = string
}


# AWS Access Key
variable "AWS_ACCESS_KEY_ID" {
  description = "AWS Access Key"
  type        = string
}

# AWS Secret Key
variable "AWS_SECRET_ACCESS_KEY" {
  description = "AWS Secret Key"
  type        = string

#AWS regions can be set for the availability zones.
variable "AWS_REGION" {
  description = "The AWS region to deploy resources in."
  type        = string
}


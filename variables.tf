# AMI ID for the EC2 instances
variable "ami_id" {
  description = "AMI ID"
  type        = string
}

variable "use_existing_resources" {
  description = "Whether to use existing IAM roles and Launch Templates. Set to true to use existing resources."
  type        = bool
  default     = false
}

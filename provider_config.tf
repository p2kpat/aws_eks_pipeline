#select provider for terraform
#https://registry.terraform.io/providers/hashicorp/aws/latest/docs
#use the link above to get for details for aws as a provider and other resource capabilities.

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider,
#These varibles will be declared through the varibles.tf file
#These variable will be defined in the terraform.tfvars file
#The region is required. 
#The Access,secret keys are optional, and same with token, based on authentication requirements by company.
provider "aws" {
   region      = var.AWS_REGION
#  access_key  = var.AWS_ACCESS_KEY_ID
#  secret_key  = var.AWS_SECRET_ACCESS_KEY

}

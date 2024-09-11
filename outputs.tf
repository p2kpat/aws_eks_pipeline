output "master_role_arn" {
  value = data.aws_iam_role.existing_master_role.arn
}

output "worker_role_arn" {
  value = data.aws_iam_role.existing_worker_role.arn
}

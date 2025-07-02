output "iam_instance_profile" {
  description = "IAM Instance Profile for SSM"  
  value = aws_iam_instance_profile.ssm_profile.name
}
output "ssm_policy_arn" {
  description = "ARN of the SSM IAM Policy"
  value       = aws_iam_policy.ssm_policy.arn
}

output "ssm_role_name" {
  description = "Name of the SSM IAM Role"
  value       = aws_iam_role.ssm_role.name
}

output "aws_iam_policy" {
  description = "IAM Policy for SSM"
  value = aws_iam_policy.ssm_policy
}
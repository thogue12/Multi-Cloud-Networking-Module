# ### use the IAM policy created for SSM ###

# resource "aws_iam_policy" "ssm_policy" {
#   name        = "AmazonSSMManagedInstanceCore"
#   path        = "/"
#   description = "SSM policy"

#   # Terraform's "jsonencode" function converts a
#   # Terraform expression result to valid JSON syntax.
#   policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#             "Effect": "Allow",
#             "Action": [
#                 "ssm:DescribeAssociation",
#                 "ssm:GetDeployablePatchSnapshotForInstance",
#                 "ssm:GetDocument",
#                 "ssm:DescribeDocument",
#                 "ssm:GetManifest",
#                 "ssm:GetParameter",
#                 "ssm:GetParameters",
#                 "ssm:ListAssociations",
#                 "ssm:ListInstanceAssociations",
#                 "ssm:PutInventory",
#                 "ssm:PutComplianceItems",
#                 "ssm:PutConfigurePackageResult",
#                 "ssm:UpdateAssociationStatus",
#                 "ssm:UpdateInstanceAssociationStatus",
#                 "ssm:UpdateInstanceInformation"
#             ],
#             "Resource": "*"
#         },
#         {
#             "Effect": "Allow",
#             "Action": [
#                 "ssmmessages:CreateControlChannel",
#                 "ssmmessages:CreateDataChannel",
#                 "ssmmessages:OpenControlChannel",
#                 "ssmmessages:OpenDataChannel"
#             ],
#             "Resource": "*"
#         },
#         {
#             "Effect": "Allow",
#             "Action": [
#                 "ec2messages:AcknowledgeMessage",
#                 "ec2messages:DeleteMessage",
#                 "ec2messages:FailMessage",
#                 "ec2messages:GetEndpoint",
#                 "ec2messages:GetMessages",
#                 "ec2messages:SendReply"
#             ],
#             "Resource": "*"
#         }
#     ]
#   })
# }

# data "aws_iam_policy_document" "ssm_policy_doc" {
#   statement {
#     actions = [
#       "sts:AssumeRole"
#     ]
#     principals {
#       type        = "Service"
#       identifiers = ["ec2.amazonaws.com"]
#     }
#     effect = "Allow"
#   }
# }

# resource "aws_iam_role" "ssm_role" {
#   name = "AmazonSSMManagedInstanceCore1"
#   assume_role_policy = data.aws_iam_policy_document.ssm_policy_doc.json
# }

# resource "aws_iam_role_policy_attachment" "attach_ssm_policy" {
#   role       = aws_iam_role.ssm_role.name
#   policy_arn = aws_iam_policy.ssm_policy.arn
# }

# resource "aws_iam_instance_profile" "ssm_profile" {
#   name = "AmazonSSMManagedInstanceCore2"
#   role = aws_iam_role.ssm_role.name
# <<<<<<< HEAD
# }
# =======
# }

# >>>>>>> main

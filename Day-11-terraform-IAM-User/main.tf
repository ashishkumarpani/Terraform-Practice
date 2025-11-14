provider "aws" {
  region = "us-east-1"
}

#------------IAM uSER--------#
resource "aws_iam_user" "user1" {
    name = "ashish"
  
}

#---create ACCESS-KEY for IAM-user---#

# resource "aws_iam_access_key" "name" {
#     user = aws_iam_user.user1.name  
# }

# Create console login profile  password #

resource "aws_iam_user_login_profile" "password" {
  user                    = aws_iam_user.user1.name
  password_length         = 12
  password_reset_required = false
  
}

#  to show password run below command
#  terraform output console_password



# ---------- custom IAM Policy for S3 ----------#

resource "aws_iam_policy" "s3_access_policy" {
  name        = "S3AccessPolicy"
  description = "Allows IAM user to list buckets, and read/write/delete in test-iam-11-11-26"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = "s3:ListAllMyBuckets"
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "s3:ListBucket"
        ]
        Resource = "arn:aws:s3:::test-iam-11-11-26"
      },
      {
        Effect = "Allow"
        Action = [
          "s3:PutObject",
          "s3:GetObject"
        ]
        Resource = "arn:aws:s3:::test-iam-11-11-26/*"
      }
    ]
  })
}



#---------- Attach new Policy to IAM User ----------#

resource "aws_iam_user_policy_attachment" "attach_s3_policy" {
  user       = aws_iam_user.user1.name                 # Replace with your IAM user resource
  policy_arn = aws_iam_policy.s3_access_policy.arn      # custom policy arn
}



#------Attach existing policy to IAM user----#

# resource "aws_iam_user_policy_attachment" "existing_policy" {
#   user       = aws_iam_user.user1.name
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
# }






# #-----if u want more existing policy attach----------#

# locals {
#   policy_arns = [
#     "arn:aws:iam::aws:policy/AmazonEC2FullAccess",
#     "arn:aws:iam::aws:policy/CloudWatchFullAccess",
#     "arn:aws:iam::aws:policy/AmazonRDSFullAccess",
#     "arn:aws:iam::aws:policy/AmazonAPIGatewayAdministrator"
#   ]
# }

# resource "aws_iam_user_policy_attachment" "multiple_policies" {
#   for_each   = toset(local.policy_arns)
#   user       = aws_iam_user.user1.name
#   policy_arn = each.value

#   depends_on = [aws_iam_user.user1]
# }




# Create an inline EC2 access policy for the user


# resource "aws_iam_user_policy" "ec2_inline_policy" {
#   name = "EC2AccessInlinePolicy"
#   user = aws_iam_user.user1.name

#   policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Effect = "Allow"
#         Action = [
#           "ec2:DescribeInstances",
#           "ec2:DescribeRegions",
#           "ec2:DescribeAvailabilityZones",
#           "ec2:DescribeInstanceStatus",
#           "ec2:DescribeImages",
#           "ec2:StartInstances",
#           "ec2:StopInstances"
#         ]
#         Resource = "*"
#       }
#     ]
#   })
# }


# existing IAM username

# data "aws_iam_user" "name" {
#   user_name = "Ashu" 
# }


# Create IAM group
resource "aws_iam_group" "developers" {
  name = "developers"
}

# Add user to the group

resource "aws_iam_user_group_membership" "ashish_in_group" {
  user = aws_iam_user.user1.name
  groups = [aws_iam_group.developers.name]
}
# resource "aws_iam_user_group_membership" "ashu_in_group" {
#   user = data.aws_iam_user.name.user_name
#   groups = [aws_iam_group.developers.name]
# }

# Attach a managed AWS policy to a group

resource "aws_iam_group_policy_attachment" "group_policy_attach" {
  group      = aws_iam_group.developers.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}











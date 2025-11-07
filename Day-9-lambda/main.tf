provider "aws" {
  
}

# ---------------- IAM Role for Lambda ---------------- #

resource "aws_iam_role" "lambda_admin_role" {
  name = "lambda-admin-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# ---------------- Attach AdministratorAccess Policy ---------------- #

resource "aws_iam_role_policy_attachment" "lambda_admin_attach" {
  role       = aws_iam_role.lambda_admin_role.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

#-------------Lambda--------------#

resource "aws_lambda_function" "lambda" {
    function_name = "lambda"
    runtime       = "python3.12"
    role          =  aws_iam_role.lambda_admin_role.arn
    handler       = "lambda_function.lambda_handler"
    timeout       = 900
    memory_size   = 128
    filename      = "lambda_function.zip"  # Ensure this file exists

   source_code_hash = filebase64sha256("lambda_function.zip")

#Without source_code_hash, Terraform might not detect when the code in the ZIP file has changed — meaning your Lambda might not update even after uploading a new ZIP.

#This hash is a checksum that triggers a deployment.
  
}

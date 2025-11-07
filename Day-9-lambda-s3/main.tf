# ------------------ AWS Provider ------------------ #
provider "aws" {

}

# ------------------ Create S3 Bucket ------------------ #

resource "aws_s3_bucket" "name" {
  bucket = "ashish-bucket-s3-15-12-25"   
  tags = {
    Name = "ashish-bucket"
  }
}

resource "aws_s3_bucket_versioning" "name" {
  bucket = aws_s3_bucket.name.id

  versioning_configuration {
    status = "Enabled"
  }
}

# ------------------ Upload Object ------------------ #

resource "aws_s3_object" "upload" {
  bucket = aws_s3_bucket.name.id
  key    = "lambda_function.zip"
  source = "lambda_function.zip"    # local file to upload to S3
  etag   = filemd5("lambda_function.zip") #detect any changes at zip
  depends_on = [ aws_s3_bucket.name ]
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

#----------------------Lambda-function--------------------------#

resource "aws_lambda_function" "ashish_lambda" {
  function_name = "s3-lambda"
  role          = aws_iam_role.lambda_admin_role.arn
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.13"

  # Load ZIP from S3
  s3_bucket = aws_s3_bucket.name.bucket
  s3_key    = aws_s3_object.upload.key

  timeout       = 900
  memory_size   = 128
  source_code_hash = filebase64sha256("lambda_function.zip")  #detect the changes
  depends_on = [aws_s3_object.upload]
}
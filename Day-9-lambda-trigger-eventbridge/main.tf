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


#--------Lambda function--------#

resource "aws_lambda_function" "name" {
  function_name = "scheduled-lambda"
  role          = aws_iam_role.lambda_admin_role.arn
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.9"
  timeout       = 900
  memory_size   = 128

  filename         = "lambda_function.zip" # Path to your packaged code
  source_code_hash = filebase64sha256("lambda_function.zip")
}



#--------Create EventBridge rule (schedule)------------#

resource "aws_cloudwatch_event_rule" "every_five_minutes" {
  name                = "every-five-minutes"
  description         = "Trigger Lambda every 5 minutes"
#   schedule_expression = "rate(5 minutes)"
  schedule_expression = "cron(0/5 * * * ? *)"

}

#-------Add the Lambda target----------------#

resource "aws_cloudwatch_event_target" "invoke_lambda" {
  rule      = aws_cloudwatch_event_rule.every_five_minutes.name
  target_id = "lambda"
  arn       = aws_lambda_function.name.arn
}

#-----Allow EventBridge to invoke the Lambda------#

resource "aws_lambda_permission" "allow_eventbridge" {
  statement_id  = "AllowExecutionFromEventBridge"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.name.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.every_five_minutes.arn
}
data "archive_file" "lambda_function" {
  type        = "zip"
  source_file = "src/secrets.py"
  output_path = "lambda_function.zip"
}

resource "aws_lambda_function" "vpc_lambda" {
  function_name = "${var.tags.Project}-${var.tags.Environment}-secrets"
  runtime       = "python3.13"
  handler       = "lambda_function.lambda_handler"
  role          = aws_iam_role.lambda_role.arn
  timeout       = 10
  memory_size   = 128

  # Lambda 関数コード
  filename         = "lambda_function.zip"
  source_code_hash = data.archive_file.lambda_function.output_base64sha256

  vpc_config {
    subnet_ids         = var.private_subnets
    security_group_ids = [module.security_group.security_group_id]
  }

  environment {
    variables = {
      SECRET_NAME = aws_secretsmanager_secret.this.name
    }
  }
}

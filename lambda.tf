locals {
  runtime = "python3.9"
  function_src_path = "lambda_function/lambda_function.zip"
  function_name = "pombo_lamdba"
}

resource "aws_lambda_function" "pombo_lamdba" {
  filename      = local.function_src_path
  function_name = local.function_name
  role          = aws_iam_role.lambda_role.arn
  handler       = "main.lambda_handler"

  source_code_hash = filebase64sha256(local.function_src_path)

  runtime = local.runtime

  environment {
    variables = {
      env = "poc"
    }
  }
}

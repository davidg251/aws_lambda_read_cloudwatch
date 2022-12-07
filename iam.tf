locals {}


resource "aws_iam_role_policy" "cloudwatch_policy" {
  name = "read-cloudwatch-policy"
  role = aws_iam_role.lambda_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
          Action   = ["logs:GetLogEvents", "logs:GetLogRecord"]
          Effect   = "Allow"
          Resource = "${aws_cloudwatch_log_stream.target_stream.arn}"
    }]
  })
}


resource "aws_iam_role" "lambda_role" {
  name = "lambda-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      },
    ]
  })
}

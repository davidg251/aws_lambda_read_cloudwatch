resource "aws_cloudwatch_log_group" "target_log_group" {
  name = "TargetLogGroup"

  tags = {
    Environment = "poc"
  }
}

resource "aws_cloudwatch_log_stream" "target_stream" {
  name           = "TargetStream"
  log_group_name = aws_cloudwatch_log_group.target_log_group.name
}
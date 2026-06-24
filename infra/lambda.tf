resource "aws_lambda_function" "processador" {

  function_name = "processador-dynamo"

  filename = "../lambda/lambda.zip"

  source_code_hash = filebase64sha256("../lambda/lambda.zip")

  runtime = "python3.13"

  handler = "handler.lambda_handler"

  role = aws_iam_role.lambda_role.arn

  environment {
    variables = {
      BUCKET_NAME = aws_s3_bucket.raw.bucket
    }
  }
}

resource "aws_lambda_event_source_mapping" "stream" {

  event_source_arn = aws_dynamodb_table.usuarios.stream_arn

  function_name = aws_lambda_function.processador.arn

  starting_position = "LATEST"
}
resource "aws_iam_role" "lambda_role" {
    name = "lambda_role"

    assume_role_policy = jsonencode({
        Version = "2012-10-17"
        Statement = [{
            Effect = "Allow"
            Principal = {
                Service = "lambda.amazonaws.com"
            }
            Action = "sts:AssumeRole"
        }]
    })
}

resource "aws_iam_role_policy" "lambda_policy" {
    name = "lambda_policy"

    role = aws_iam_role.lambda_role.id

    policy = jsonencode({
        Version = "2012-10-17"

        Statement = [
            {
                Effect = "Allow"
                Action = [
                    "s3: PutObject"
                ]
                Resource = [
                    "${aws_s3_bucket.raw.arn}/*"
                ]
            },

            {
                Effect = "Allow"
                Action = [
                    "logs:*"
                ]
                Resource = "*"
            }
        ]
    })
}
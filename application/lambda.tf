data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "iam_for_lambda" {
  name               = "iam_for_lambda"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_lambda_function" "test_lambda" {
  # If the file is not in the current working directory you will need to include a
  # path.module in the filename.
  image_uri     = var.image_uri
  role          = aws_iam_role.iam_for_lambda.arn
  function_name = "test_lambda"
  image_config {
    command = ["handlers.lambda_handler"]
  }
  environment {
    variables = {
      foo = "bar"
    }
  }
}

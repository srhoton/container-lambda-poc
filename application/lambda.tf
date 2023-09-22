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
  architectures = ["ARM64"]
  package_type = "Image"
  image_uri = "874500785305.dkr.ecr.us-west-2.amazonaws.com/container-lambda-poc:initial-setup"
  #image_uri     = var.image_uri
  role          = aws_iam_role.iam_for_lambda.arn
  function_name = "test_lambda"
  image_config {
    command = ["handlers.lambda_handler"]
  }
}

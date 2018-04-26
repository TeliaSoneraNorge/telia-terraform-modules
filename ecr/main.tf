resource "aws_ecr_repository" "this" {
  name = "${var.repo_name}"
}

data "aws_iam_policy_document" "ecr_pull_only_policy" {
  statement {
    actions = [
      "ecr:BatchCheckLayerAvailability",
      "ecr:BatchGetImage",
      "ecr:DescribeImages",
      "ecr:DescribeRepositories",
      "ecr:GetAuthorizationToken",
      "ecr:GetDownloadUrlForLayer",
      "ecr:GetRepositoryPolicy",
      "ecr:ListImages",
    ]

    principals {
      type = "AWS"

      identifiers = [
        "${formatlist("arn:aws:iam::%s:root", var.trusted_accounts)}",
      ]
    }
  }
}

resource "aws_ecr_repository_policy" "this" {
  repository = "${aws_ecr_repository.this.name}"
  policy     = "${data.aws_iam_policy_document.ecr_pull_only_policy.json}"
}

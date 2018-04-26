data "aws_iam_policy_document" "assume" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type = "AWS"

      identifiers = [
        # The ARN of the Lambda role that provides creds to concourse.
        # This account number is managed by the DivX team in the repo
        # TeliaSoneraNorge/divx-account-setup.
        # https://github.com/TeliaSoneraNorge/divx-account-setup/blob/master/telia-divx-xqb-dev/roles/machine-user.tf
        "arn:aws:iam::794493081671:role/concourse-ci-sts-credentials-lambda-role", # prod

        "arn:aws:iam::951215386089:role/concourse-ci-sts-credentials-lambda-role", # staging
      ]
    }
  }
}

data "aws_iam_policy_document" "this" {
  # Does not support resource-level permissions: https://docs.aws.amazon.com/AmazonECR/latest/userguide/ecr-supported-iam-actions-resources.html
  statement {
    actions = [
      "ecr:GetAuthorizationToken",
    ]

    resources = ["*"]
  }

  statement {
    actions = [
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:GetRepositoryPolicy",
      "ecr:DescribeRepositories",
      "ecr:ListImages",
      "ecr:DescribeImages",
      "ecr:BatchGetImage",
      "ecr:InitiateLayerUpload",
      "ecr:UploadLayerPart",
      "ecr:CompleteLayerUpload",
      "ecr:PutImage",
    ]

    resources = ["arn:aws:ecr:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:repository/${var.namespace}/*"]
  }

  # SOURCE: https://www.packer.io/docs/builders/amazon.html#iam-task-or-instance-role
  statement {
    actions = [
      "ec2:AttachVolume",
      "ec2:AuthorizeSecurityGroupIngress",
      "ec2:CopyImage",
      "ec2:CreateImage",
      "ec2:CreateKeypair",
      "ec2:CreateSecurityGroup",
      "ec2:CreateSnapshot",
      "ec2:CreateTags",
      "ec2:CreateVolume",
      "ec2:DeleteKeypair",
      "ec2:DeleteSecurityGroup",
      "ec2:DeleteSnapshot",
      "ec2:DeleteVolume",
      "ec2:DeregisterImage",
      "ec2:DescribeImageAttribute",
      "ec2:DescribeImages",
      "ec2:DescribeInstances",
      "ec2:DescribeRegions",
      "ec2:DescribeSecurityGroups",
      "ec2:DescribeSnapshots",
      "ec2:DescribeSubnets",
      "ec2:DescribeTags",
      "ec2:DescribeVolumes",
      "ec2:DetachVolume",
      "ec2:GetPasswordData",
      "ec2:ModifyImageAttribute",
      "ec2:ModifyInstanceAttribute",
      "ec2:ModifySnapshotAttribute",
      "ec2:RegisterImage",
      "ec2:RunInstances",
      "ec2:StopInstances",
      "ec2:TerminateInstances",
    ]

    resources = ["*"]
  }
}

resource "aws_iam_role" "this" {
  name               = "machine-user-ecr-${var.namespace}"
  assume_role_policy = "${data.aws_iam_policy_document.assume.json}"
}

resource "aws_iam_policy" "this" {
  name   = "machine-user-ecr-${var.namespace}-policy"
  policy = "${data.aws_iam_policy_document.this.json}"
}

resource "aws_iam_role_policy_attachment" "this" {
  role       = "${aws_iam_role.this.name}"
  policy_arn = "${aws_iam_policy.this.arn}"
}

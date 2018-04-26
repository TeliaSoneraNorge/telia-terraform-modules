resource "aws_iam_role" "service_role" {
  name               = "${var.service_role_name}"
  assume_role_policy = "${data.aws_iam_policy_document.service_role_policy.json}"
}

data "aws_iam_policy_document" "service_role_policy" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "AWS"
      identifiers = ["${var.assuming_principal_identifiers}"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "service_role_policy_attachment" {
  role       = "${aws_iam_role.service_role.name}"
  policy_arn = "${var.role_policy_arn}"
}

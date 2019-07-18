resource "aws_iam_role" "oidc_role" {
  name = "oidc-role-${random_string.suffix.result}"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws-cn:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/${var.providerName}"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "${var.providerName}:aud": "${var.clientId}"
        }
      }
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "s3_access_policy" {
  role = aws_iam_role.oidc_role.id
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "ListYourObjects",
            "Effect": "Allow",
            "Action": "s3:ListBucket",
            "Resource": [
                "arn:aws-cn:s3:::${aws_s3_bucket.s3.bucket}"
            ],
            "Condition": {
                "StringLike": {
                    "s3:prefix": [
                        "${var.app}/$${${var.providerName}:sub}"
                    ]
                }
            }
        },
        {
            "Sid": "ReadWriteDeleteYourObjects",
            "Effect": "Allow",
            "Action": [
                "s3:GetObject",
                "s3:PutObject",
                "s3:DeleteObject"
            ],
            "Resource": [
                "arn:aws-cn:s3:::${aws_s3_bucket.s3.bucket}/${var.app}/$${${var.providerName}:sub}",
                "arn:aws-cn:s3:::${aws_s3_bucket.s3.bucket}/${var.app}/$${${var.providerName}:sub}/*"
            ]
        }
    ]
}
EOF
}


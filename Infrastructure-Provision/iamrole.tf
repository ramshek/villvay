# Create an IAM role for the Web Servers.
resource "aws_iam_role" "villvay_iam_role" {
    name = "villvay_iam_role"
    assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_instance_profile" "villvay_instance_profile" {
    name = "villvay_instance_profile"
    role = aws_iam_role.villvay_iam_role.name
}

resource "aws_iam_role_policy" "villvay_iam_role_policy" {
  name = "villvay_iam_role_policy"
  role = aws_iam_role.villvay_iam_role.id
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": ["s3:ListBucket"],
      "Resource": ["arn:aws:s3:::villvaybucket"]
    },
    {
      "Effect": "Allow",
      "Action": [
        "s3:PutObject",
        "s3:GetObject",
        "s3:DeleteObject"
      ],
      "Resource": ["arn:aws:s3:::villvaybucket/*"]
    }
  ]
}
EOF
}

resource "aws_s3_bucket" "villvaybucket" {
    bucket = "villvaybucket"
    acl = "private"
    versioning {
            enabled = true
    }
    }

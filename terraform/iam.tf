resource "aws_iam_role" "mongodb" {
  name = "wiz-now-mongodb-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Service = "ec2.amazonaws.com"
        }

        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Name = "wiz-now-mongodb-role"
  }
}

resource "aws_iam_role_policy" "mongodb_ec2" {
  name = "wiz-now-mongodb-ec2-permissions"
  role = aws_iam_role.mongodb.id

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Action = [
          "ec2:RunInstances",
          "ec2:CreateTags"
        ]

        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_instance_profile" "mongodb" {
  name = "wiz-now-mongodb-profile"
  role = aws_iam_role.mongodb.name

  tags = {
    Name = "wiz-now-mongodb-profile"
  }
}

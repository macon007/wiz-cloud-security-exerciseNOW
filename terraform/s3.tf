resource "aws_s3_bucket" "mongodb_backup" {
  bucket = "wiz-now-mongodb-backup-309509180673"

  tags = {
    Name = "wiz-now-mongodb-backup"
  }
}

resource "aws_s3_bucket_public_access_block" "mongodb_backup" {
  bucket = aws_s3_bucket.mongodb_backup.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}


































resource "aws_s3_bucket_policy" "mongodb_backup_public" {
  bucket = aws_s3_bucket.mongodb_backup.id



  depends_on = [
    aws_s3_bucket_public_access_block.mongodb_backup
  ]

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Sid       = "PublicRead"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.mongodb_backup.arn}/*"
      },
      {
        Sid       = "PublicList"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:ListBucket"
        Resource  = aws_s3_bucket.mongodb_backup.arn
      }
    ]
  })
}

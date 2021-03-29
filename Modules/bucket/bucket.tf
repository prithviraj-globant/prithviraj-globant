resource "aws_s3_bucket" "test-bucket" {
  bucket = "test-bucket"
  acl    = "private"

  tags = {
    Name        = "demo bucket"
    Environment = "Dev"
  }
}

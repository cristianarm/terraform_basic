
#----------------------------------------------------
#         Storage
#----------------------------------------------------

# resource  S3 bucket
resource "aws_s3_bucket" "tf_bucket_r_useast1" {
  bucket = "s3-ec2-tf-bucket1"

  tags = {
    Name        =  "${var.namespace}-${var.stage}-s3-bucket"
  }
}

resource "aws_s3_bucket_acl" "tf_bucket_acl" {
  bucket = aws_s3_bucket.tf_bucket_r_useast1.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "tf_bucket_versioning" {
  bucket = aws_s3_bucket.tf_bucket_r_useast1.id
  versioning_configuration {
    status = "Enabled"
  }
}
output "ec2_id" {
  value = aws_instance.this_ec2[*].id
}
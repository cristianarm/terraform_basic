output "vpc_id" {
  value = aws_vpc.tf_vpc.id
}

output "sb_publ_id" {
  value = aws_subnet.tf_pub-sn.id
}

output "sb_priv_id" {
  value = aws_subnet.pri-sub
}



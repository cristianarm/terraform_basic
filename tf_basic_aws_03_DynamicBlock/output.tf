output "webapp_public_ip" {
  description = "The public IP address assigned to the instance, if applicable. NOTE: If you are using an aws_eip with your instance, you should refer to the EIP's address directly and not use `public_ip` as this field will change after the EIP is attached"
  value       = aws_instance.tf_app_server.public_ip
}
output "bastion_public_ip" {
  description = "The public IP address assigned to the instance, if applicable. NOTE: If you are using an aws_eip with your instance, you should refer to the EIP's address directly and not use `public_ip` as this field will change after the EIP is attached"
  value       = aws_instance.tf_bastion.public_ip
}
output "eip_public_ip" {
  description = "Elastic ip address for Nat gateway"
  value       = aws_eip.tf_eip.*.public_ip
}
output "backend_priv_ip" {
  description = "The public IP address assigned to the instance, if applicable. NOTE: If you are using an aws_eip with your instance, you should refer to the EIP's address directly and not use `public_ip` as this field will change after the EIP is attached"
  value       = aws_instance.tf_backend[*].private_ip
}
output "ami-amazon-linux-2" {
  description = "AMI for Amazon Linux 2"
  value       = data.aws_ami.amazon-linux-2.id
}
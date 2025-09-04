locals {
  ami_id= (var.ec2_ami != "amzl" ? data.aws_ami.ubuntu-20.id : data.aws_ami.amazon-linux-2.id  )
}


resource "aws_instance" "this_ec2" {

    for_each = var.sub_pub_ids

    ami              = local.ami_id
    instance_type    = var.ec2_type_instance
    subnet_id        = each.key
    key_name         = var.key_name
    user_data = file("ud_httpd.sh")
    tags             = var.tags

}
resource "aws_instance" "this_ec2" {

    for_each = var.sub_pub_ids
    ami              = var.ec2_ami
    instance_type    = var.ec2_type_instance
    subnet_id        = each.key
    key_name         = var.key_name

    tags             = var.tags

}
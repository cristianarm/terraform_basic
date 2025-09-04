#  Terraform Provisioner
# https://www.terraform.io/language/resources/provisioners/syntax
# https://www.terraform.io/language/resources/provisioners/file
# https://www.terraform.io/language/resources/provisioners/remote-exec
# https://www.terraform.io/language/resources/provisioners/local-exec
# https://www.devopsschool.com/blog/understanding-local-exec-provisioner-in-terraform/


resource "aws_instance" "app-dev" {
   #ami = lookup(var.ami,var.region)
   ami = data.aws_ami.amazon-linux-2.id
   instance_type = "t2.micro"
   key_name = var.key_name
   subnet_id = "subnet-0cd24d202b4d3c485"
   associate_public_ip_address = true
   vpc_security_group_ids = ["sg-0839f7cff85fdfaf4"]

   tags = {
     Name = "ac-demo-ec2"
   }

   provisioner "file" {
       source      = "ud_httpd.sh"
       destination = "/tmp/ud_httpd.sh"
     }

   provisioner "remote-exec" {
     inline = [
           "chmod +x /tmp/ud_httpd.sh",
           "/tmp/ud_httpd.sh",
         ]
      on_failure = continue
    }


    connection {
       type     = "ssh"
       user     = "ec2-user"
       host     = self.public_ip
       private_key   = file(var.key_file)
     }

    provisioner "local-exec" {
        command = "echo ${self.private_ip} >> private_ips.txt"
    }
    provisioner "local-exec" {
        command = "echo ${self.public_ip} >> public_ip.txt"
    }
}


resource "null_resource" "null_res" {
  provisioner "local-exec" {
    command = "date  >> completed.txt"
  }
}


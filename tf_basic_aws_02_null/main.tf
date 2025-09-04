
# Defining the Elastic IP Address for NAT
resource "aws_eip" "tf_eip" {
  #vpc      = true -- deprecated
  count = 2
  tags = {
    Name  = "eip_demo"
  }
  #depends_on = [
  #  null_resource.healtcceck
  #]
}


resource "null_resource" "healtcceck" {
    triggers = {
      "EIP_GEN" = join(",",aws_eip.tf_eip[*].public_ip)
    }
  provisioner "local-exec" {
    #command = "curl duckduckgo.com"
    command = "echo generates EIP are ${null_resource.healtcceck.triggers.EIP_GEN} > list.txt" 
  } 
}
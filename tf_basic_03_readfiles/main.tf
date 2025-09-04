locals {
    # get json 
    user_data = jsondecode(file("${path.module}/users.json"))

    # get all users
    all_users = [for user in local.user_data.users : user.user_name]
    
    # get dev users
    uniq_dev_roles = distinct([for user in local.user_data.users : user.role])

     # get dev ssh-key
    uniq_ssh_key = distinct([for user in local.user_data.users : user.ssh_key])

}
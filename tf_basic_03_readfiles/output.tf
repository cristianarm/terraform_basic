output "users" {
    value = local.all_users[*]
}

output "byname" {
  value = local.user_data.users[*].user_name
}

output "dev_roles" {
  value = local.uniq_dev_roles[*]
}

output "ssh_keys" {
  value = local.uniq_ssh_key
  
}
#Output the name of the Container
output "docker_image" {
 description = "The docker Image"
 value       = docker_image.imag.name
}
output "docker_name" {
 description = "The docker Container"
 value       = docker_container.conta.name
}
output "docker_id" {
 description = "The docker Container ID"
 value       = docker_container.conta.id
}
output "docker_ip" {
 description = "The docker Container IP"
 value       = docker_container.conta.ip_address
}
output "docker_port" {
 description = "The docker Container Port"
 value       = "${lookup(var.ext_port, var.env)}"
}
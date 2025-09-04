# resource image Docker
resource "docker_image" "imag" {
  #name         = "nginx:latest"
  name         = var.version_image
  keep_locally = true
}

# resource container
resource "docker_container" "conta" {
  image = docker_image.imag.latest
  name  = "demodocker1"
  ports {
    internal = 80
    external = 8000
  }
}

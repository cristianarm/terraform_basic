# exec terrafom with params 
# terraform plan -var env=dev
# terraform apply 

# exec terrafom with params without affect deploy
# terraform plan -out=tfdev_plan -var env=dev
# terraform apply tfdev_plan


#pull the image 
resource "docker_image" "imag" {
  #name         = "nginx:latest"
  name          =  var.version_image
  keep_locally  = false
}

#Create Container
resource "docker_container" "conta" {
  image   = docker_image.imag.latest
  name    = "${lookup(var.container_name, var.env)}"
  restart = "always"
  ports {
    internal = "${var.int_port}"
    external = "${lookup(var.ext_port, var.env)}"
  }
}
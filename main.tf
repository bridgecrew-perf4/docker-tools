resource "null_resource" "slack" {

  triggers = {
    key = "${uuid()}"
  }

  provisioner "local-exec" {
    command = "echo test"
  }
}

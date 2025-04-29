resource "null_resource" "local_exec_provisioner" {
  provisioner "local-exec" {
    command = "sleep 200"
    interpreter = ["/bin/bash", "-c"]
  }
}
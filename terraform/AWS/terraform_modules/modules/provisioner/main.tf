resource "null_resource" "ansible_provisioner" {

  connection {
    type     = "ssh"
    user     = "ec2-user"
    password = var.password
    host     = var.server_ip
  }
    provisioner "remote-exec" {
      inline = [
        "sudo cd /home/ec2-user/", "echo provisioner >> /tmp/prov.txt"
      ]
    }
}


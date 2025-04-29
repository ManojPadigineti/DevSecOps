resource "null_resource" "ansible_playbook" {

  provisioner "remote-exec" {
    connection {
      type     = "ssh"
      user     = "ec2-user"
      password = var.password
      host     = var.server_ip
    }
    inline = [
      "ansible-playbook -i inv.txt playbook.yml -e var_file=${var.instances}"
    ]
  }
}
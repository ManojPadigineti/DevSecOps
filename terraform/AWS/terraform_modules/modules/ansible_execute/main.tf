resource "null_resource" "ansible_playbook" {
  connection {
    type     = "ssh"
    user     = "ec2-user"
    password = var.password
    host     = var.server_ip
  }

  provisioner "remote-exec" {
    inline = [
      "sudo -i ; cd /home/ec2-user/DevSecOps_Project/ansible_terraform"
    ]
  }
  provisioner "remote-exec" {
    inline = [
      "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i inv.txt playbook.yml -e var_file=${var.instances}"
    ]

  }
}
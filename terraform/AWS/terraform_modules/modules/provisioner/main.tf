resource "null_resource" "ansible_provisioner" {

  connection {
    type     = "ssh"
    user     = "ec2-user"
    password = var.password
    host     = var.server_ip
  }
  provisioner "file" {
    source     = "/c/Users/ADMIN/Desktop/DevOps/DevSecOps/ansible/install_ansible.sh"
    destination = "/home/ec2-user/install_ansible.sh"
  }
  provisioner "remote-exec" {
    inline = [
      "sudo cd /home/ec2-user/", "bash install_ansible.sh"
    ]
  }
}


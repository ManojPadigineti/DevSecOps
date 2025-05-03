resource "null_resource" "terraform_provisioner" {

  connection {
    type     = "ssh"
    user     = "root"
    password = var.password
    host     = var.public_ip
  }

  provisioner "remote-exec" {
    inline = [
       "git clone https://github.com/ManojPadigineti/ansible_playbook.git",
        "sudo bash ansible_playbook/Install_terraform.sh"
    ]
  }
}



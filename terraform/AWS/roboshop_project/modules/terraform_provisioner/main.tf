resource "null_resource" "terraform_provisioner" {

  connection {
    type     = "ssh"
    user     = "ec2-user"
    password = var.password
    host     = var.public_ip
  }

  provisioner "remote-exec" {
    inline = [
       "git clone https://github.com/ManojPadigineti/ansible_playbook.git",
        "git pull ; sudo bash ansible_playbook/Install_terraform.sh",
        "git pull ; sudo bash ansible_playbook/install_ansible.sh",
         "git pull ; ansible-playbook -i localhost playbook.yml -e var_file=hashicorp"
    ]
  }
}



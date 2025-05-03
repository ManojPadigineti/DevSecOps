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
        "sudo bash ansible_playbook/install_ansible.sh",
        "cd /home/ec2-user/ansible_playbook/ ; git pull; ansible-playbook -i localhost playbook.yml -e var_file=${var.server_name}"
    ]
  }
}



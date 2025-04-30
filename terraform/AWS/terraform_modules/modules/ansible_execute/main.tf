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
      # "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i inv.txt playbook.yml -e var_file=${var.instances}"
    ]
  }
  provisioner "remote-exec" {
    inline = [
      "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i inv.txt playbook.yml -e var_file=mongodb",
      "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i inv.txt playbook.yml -e var_file=redis",
      "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i inv.txt playbook.yml -e var_file=mysql",
      "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i inv.txt playbook.yml -e var_file=rabbitmq",
      "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i inv.txt playbook.yml -e var_file=catalogue",
      "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i inv.txt playbook.yml -e var_file=user",
      "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i inv.txt playbook.yml -e var_file=cart",
      "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i inv.txt playbook.yml -e var_file=shipping",
      "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i inv.txt playbook.yml -e var_file=payment",
      "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i inv.txt playbook.yml -e var_file=dispatch",
      "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i inv.txt playbook.yml -e var_file=frontend"
    ]

  }
}
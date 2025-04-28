resource "null_resource" "public_ip_checker" {
  triggers = {
    public_ip = var.public_ip
  }
}

resource "vault_mount" "kv2" {
  path        = "/v1/v1/manoj/data/credentials/data/devops"
  type        = "kv"
  options     = { version = "2" }
}

resource "vault_kv_secret_v2" "example" {
  mount               = vault_mount.kv2.path
  name                = "devops"
  delete_all_versions = false
  data_json = jsonencode(
    {
      name = "manoj",
      role = "devops",
      offer = "yes"
    }
  )
}

data "vault_kv_secret_v2" "example" {
  mount = "manoj"
  name  = "credentials"
}

resource "local_file" "copy_to_local" {
  filename = "credentials_from_vault"
  content = data.vault_kv_secret_v2.example.data_json
}
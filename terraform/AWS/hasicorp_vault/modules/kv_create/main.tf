
data "vault_kv_secret_v2" "credentials" {
  mount = "kv/data/ "
  name  = "credentials"
}

resource "local_file" "copy_to_local" {
  filename = "credentials_from_vault"
  content = data.vault_kv_secret_v2.credentials.data["password"]
}
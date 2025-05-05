

resource "vault_generic_secret" "example" {
  path = "secret/foo"

  data_json = jsonencode(
    {
      "foo"   = "bar",
      "pizza" = "cheese"
    }
  )
}
path "secret/evernewapp" {
  capabilities = ["read", "list"]
}

path "mysql/creds/evernewapp" {
  capabilities = ["read", "list"]
}

path "sys/renew/*" {
  capabilities = ["update"]
}

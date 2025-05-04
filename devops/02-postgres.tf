// --------------------------------------------------------
// KESTRA
// --------------------------------------------------------

resource "random_password" "kestra_postgres" {
  length  = 32
  special = false

  depends_on = [
    null_resource.minio,
  ]
}

resource "postgresql_role" "kestra_postgres" {
  name     = "kestra"
  login    = true
  password = random_password.kestra_postgres.result

  depends_on = [
    random_password.kestra_postgres,
  ]
}

resource "postgresql_database" "kestra_postgres" {
  name  = "kestra"
  owner = postgresql_role.kestra_postgres.name

  depends_on = [
    postgresql_role.kestra_postgres,
  ]
}

resource "null_resource" "postgres" {
  depends_on = [
    // parent
    null_resource.minio,
    // resources: kestra
    random_password.kestra_postgres,
    postgresql_role.kestra_postgres,
    postgresql_database.kestra_postgres,
  ]
}
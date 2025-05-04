resource "nomad_namespace" "kestra" {
  name = "kestra-system"

  depends_on = [
    null_resource.postgres,
  ]
}

resource "random_password" "kestra_admin_password" {
  length  = 32
  special = false

  depends_on = [
    nomad_namespace.kestra,
  ]
}

resource "nomad_variable" "kestra_postgres_configuration" {
  path      = "kestra/configuration/postgres"
  namespace = nomad_namespace.kestra.id
  items = {
    host     = "${var.provider_postgres_host}"
    port     = "${var.provider_postgres_port}"
    database = "kestra"
    username = "kestra"
    password = "${random_password.kestra_admin_password.result}"
  }

  depends_on = [
    nomad_namespace.kestra,
  ]
}

resource "null_resource" "kestra" {
  depends_on = [
    // parent
    null_resource.postgres,
    // resources
    nomad_namespace.kestra,
    random_password.kestra_admin_password,
    nomad_variable.kestra_postgres_configuration,
  ]
}
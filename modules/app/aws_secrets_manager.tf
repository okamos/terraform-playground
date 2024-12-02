# data "sops_file" "secrets" {
#   source_file = "secrets.yaml"
# }

resource "aws_secretsmanager_secret" "this" {
  name = "${var.tags.Project}-${var.tags.Environment}-secret"
}

resource "aws_secretsmanager_secret_version" "this" {
  secret_id = aws_secretsmanager_secret.this.id
  secret_string = jsonencode({
    username = "admin",
    # password = data.sops_file.secrets["secret"]
    password = "password1234"
  })
}

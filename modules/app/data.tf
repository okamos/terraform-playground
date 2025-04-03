data "external" "hits" {
  program = [
    "aws", "ecr", "describe-images",
    "--repository-name", "playground-test",
    "--query", "{\"tags\": to_string(sort_by(imageDetails,& imagePushedAt)[-1].imageTags[-1])}",
  ]
}

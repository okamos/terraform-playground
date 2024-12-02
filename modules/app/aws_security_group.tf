module "security_group" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "${var.tags.Project}-${var.tags.Environment}-app"
  description = "Security group for the application"
  vpc_id      = var.vpc_id

  ingress_cidr_blocks = []
  egress_cidr_blocks  = []

  tags = var.tags
}

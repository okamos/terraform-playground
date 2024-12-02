include "root" {
  path = find_in_parent_folders()
}

locals {
  tag_vars = read_terragrunt_config(find_in_parent_folders("tags.hcl"))

  tags = local.tag_vars.locals.tags
}

terraform {
  # use relative path
  source = "${dirname(find_in_parent_folders())}/modules/network"
}

inputs = {
  name = "${local.tags.Project}-${local.tags.Environment}-vpc"
  cidr = "10.199.0.0/16"

  private_subnets  = ["10.199.129.0/24", "10.199.130.0/24", "10.199.131.0/24"]
  public_subnets   = ["10.199.1.0/24", "10.199.2.0/24", "10.199.3.0/24"]
  database_subnets = ["10.199.193.0/24", "10.199.194.0/24", "10.199.195.0/24"]

  tags = {
    Plus = "hoge"
  }
}

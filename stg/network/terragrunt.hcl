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
  cidr = "10.200.0.0/16"

  private_subnets  = ["10.200.129.0/24", "10.200.130.0/24"]
  public_subnets   = ["10.200.1.0/24", "10.200.2.0/24"]
  database_subnets = ["10.200.193.0/24", "10.200.194.0/24"]

  tags = {
    Plus = "hoge"
  }
}

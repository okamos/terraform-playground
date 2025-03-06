include "root" {
  path = find_in_parent_folders()
}

locals {
  tag_vars = read_terragrunt_config(find_in_parent_folders("tags.hcl"))

  tags = local.tag_vars.locals.tags
}

dependency "network" {
  config_path = "../network"
}

terraform {
  source = "${dirname(find_in_parent_folders())}/modules/app"
}

inputs = {
  vpc_id = dependency.network.outputs.vpc_id
  private_subnets = dependency.network.outputs.private_subnets

  tags = local.tags
}

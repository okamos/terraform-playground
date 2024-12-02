generate "provider" {
  path = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
provider "aws" {
  region = "${local.aws_region}"

  default_tags {
    tags = {
      Project = "${local.tags.Project}"
      Environment = "${local.tags.Environment}"
      Owner = "${local.tags.Owner}"
    }
  }
}

provider "aws" {
  alias  = "virginia"
  region = "us-east-1"

  default_tags {
    tags = {
      Project = "${local.tags.Project}"
      Environment = "${local.tags.Environment}"
      Owner = "${local.tags.Owner}"
    }
  }
}
EOF
}

remote_state {
  backend = "s3"
  config = {
    encrypt = true
    bucket = "${local.tags.Project}-${local.tags.Environment}-terraform-state"
    key = "${path_relative_to_include()}/terraform.tfstate"
    dynamodb_table = "${local.tags.Project}-${local.tags.Environment}-backend-locking"
    region = local.aws_region
  }
  generate = {
    path = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}

locals {
  account_vars = read_terragrunt_config(find_in_parent_folders("account.hcl"))
  tag_vars = read_terragrunt_config(find_in_parent_folders("tags.hcl"))
  region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))

  tags = local.tag_vars.locals.tags
  account_id = local.account_vars.locals.account_id
  account_name = local.account_vars.locals.account_name
  aws_region = local.region_vars.locals.aws_region
}

# Indicate the input values to use for the variables of the module.
inputs = merge(
  local.tag_vars.locals,
)

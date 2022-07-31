include "root" {
  path = find_in_parent_folders("root.hcl")
}

locals {
  # Automatically load environment-level variables
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
}

terraform {
  source = "git@github.com:terraform-aws-modules/terraform-aws-s3-bucket.git?ref=${local.environment_vars.locals.s3_version}"
}

inputs = {
  bucket = "jakefau-nxtgen-api-private-bucket"
  acl    = "private"

  versioning = {
    enabled = true
  }
}
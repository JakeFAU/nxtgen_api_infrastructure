include "root" {
  path = find_in_parent_folders("root.hcl")
}

include "region" {
  path = find_in_parent_folders("region.hcl")
}

locals {
  # Automatically load environment-level variables
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
}

terraform {
  source = "git@github.com:JakeFAU/nxtgen_modules.git//modules/s3private?ref=v0.0.1"
}

inputs = {
  bucket_name = "jakefau-nxtgen-api-lambda-code"
  versioning_status = "Enabled"
  tags = {
    terraform = true
    terragrunt = true
    component = "s3bucket"
    application = "nxtgen-api"
  }

}
include "root" {
  path = find_in_parent_folders("root.hcl")
}

locals {
  # Automatically load environment-level variables
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))

  # Automatically load region-level variables
  region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))
}

terraform {
  source = "git@github.com:JakeFAU/nxtgen_modules.git//modules/lambda_layer?ref=v0.0.3"
}

dependency "s3bucket" {
  config_path = "../../../s3/lambda_code_bucket"
}

inputs = {
  aws_region = local.region_vars.locals.aws_region
  lambda_layer_bucket = dependency.s3bucket.outputs.s3_bucket_id
  layer_name = "logging_layer"
  tags = {
    terraform = true
    terragrunt = true
    component = "lambda_layer"
    application = "nxtgen-api"
  }

}

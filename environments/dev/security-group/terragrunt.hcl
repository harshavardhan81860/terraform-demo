include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../modules/security-group"
}

# 1. Declare the dependency block FIRST with mock outputs
dependency "vpc" {
  config_path = "../vpc"

  mock_outputs = {
    vpc_id = "mock-vpc-id-12345"
  }
  mock_outputs_allowed_terraform_commands = ["validate", "plan", "init"]
}

# 2. Assign the input parameters SECOND
inputs = {
  vpc_id = dependency.vpc.outputs.vpc_id
}

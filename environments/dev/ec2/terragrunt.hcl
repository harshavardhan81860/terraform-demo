include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../modules/ec2"
}

# Declare VPC dependency with mocks
dependency "vpc" {
  config_path = "../vpc"

  mock_outputs = {
    public_subnet_id = "mock-subnet-id-12345"
  }
  mock_outputs_allowed_terraform_commands = ["validate", "plan", "init"]
}

# Declare Security Group dependency with mocks
dependency "sg" {
  config_path = "../security-group"

  mock_outputs = {
    security_group_id = "mock-sg-id-12345"
  }
  mock_outputs_allowed_terraform_commands = ["validate", "plan", "init"]
}

inputs = {
  ami_id            = "ami-007020fd9c84e18c7"
  instance_type     = "t3.micro"
  subnet_id         = dependency.vpc.outputs.public_subnet_id
  security_group_id = dependency.sg.outputs.security_group_id
}

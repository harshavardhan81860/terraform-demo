include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../modules/ec2"
}

dependency "vpc" {
  config_path = "../vpc"
}

dependency "sg" {
  config_path = "../security-group"
}

inputs = {
  ami_id            = "ami-007020fd9c84e18c7" # Ubuntu 22.04 LTS in ap-south-1
  instance_type     = "t3.micro"
  subnet_id         = dependency.vpc.outputs.public_subnet_id
  security_group_id = dependency.sg.outputs.security_group_id
}

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
  ami           = "ami-0f58b397bc5c1f2e8"
  instance_type = "t3.small"
  subnet_id     = dependency.vpc.outputs.subnet_id
  sg_id         = dependency.sg.outputs.sg_id
}

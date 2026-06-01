# environments/terragrunt.hcl

# Automatically configure and generate the S3 remote backend state tracking engine
remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    bucket         = "harsha-demo-bucket-123345-${path_relative_to_include()}" # Dynamically separates state files per app
    key            = "terraform.tfstate"
    region         = "ap-south-1"
    encrypt        = true
    dynamodb_table = "terraform-lock-table" # Prevents concurrent state file overwrites
  }
}

# Automatically generate the AWS provider file inside all child working directories
generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "aws" {
  region = "ap-south-1"
}
EOF
}

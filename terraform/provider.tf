provider "aws" {
  region = "ap-southeast-2"

  default_tags {
    tags = {
      Project     = "Wiz Technical Exercise"
      Environment = "Lab"
      ManagedBy   = "Terraform"
    }
  }
}

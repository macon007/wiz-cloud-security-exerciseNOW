terraform {
  backend "s3" {
    bucket       = "wiz-tf-state-309509180673-ap-southeast-2"
    key          = "wiz-cloud-security-exerciseNOW/terraform.tfstate"
    region       = "ap-southeast-2"
    use_lockfile = true
  }
}

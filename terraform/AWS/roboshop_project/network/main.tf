module "vpc" {
  for_each = var.vpc
  source = "../modules/vpc"
  cidr = each.value.cidr
  vpc  = each.key
}
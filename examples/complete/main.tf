locals {
  vpc_id = "vpc-1234567890"
  subnet_ids = [
    "subnet-1234567890",
    "subnet-1234567891",
    "subnet-1234567892",
  ]
}

module "penpot" {
  source = "../../."

  name                = "complete-example"
  vpc_id              = local.vpc_id
  database_subnet_ids = local.subnet_ids
}

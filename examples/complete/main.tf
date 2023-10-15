data "aws_vpc" "example" {
  tags = {
    Name = "sandbox"
  }
}

data "aws_subnets" "private" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.example.id]
  }

  filter {
    name = "tag:Name"
    values = [
      "sandbox-private-app-0",
      "sandbox-private-app-1",
      "sandbox-private-app-2",
    ]
  }
}

locals {
  vpc_id     = data.aws_vpc.example.id
  subnet_ids = data.aws_subnets.private.ids
}

module "penpot" {
  source = "../../."

  name   = "complete-example"
  vpc_id = local.vpc_id

  database_subnet_ids = local.subnet_ids
  database_multi_az   = false

  ecs_cluster_name = "complete-example"
}

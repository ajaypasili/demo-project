locals {
  cpu_map = {
    dev = "t3.small"
    test = "t3.micro"
    prod = "t2.large"
  }

  owner_map = {
    dev = "developerproject"
    test = "testerproject"
    prod = "production project"

  }
  cpu = lookup(local.cpu_map, terraform.workspace, "t2.micro")
  owner = lookup(local.owner_map, terraform.workspace, "ajju")
}

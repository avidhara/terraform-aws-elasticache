resource "aws_elasticache_subnet_group" "this" {
  count       = var.enabled ? 1 : 0
  name        = format("%s-subnet-group", var.name)
  description = var.subnet_group_description
  subnet_ids  = var.subnet_ids
}
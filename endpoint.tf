# # Purpose: Create VPC endpoint for ElastiCache
# resource "aws_vpc_endpoint" "this" {
#   count = var.create_vpc_endpoint ? 1 : 0

#   vpc_id             = var.vpc_id
#   service_name       = "com.amazonaws.us-west-1.elasticache"
#   auto_accept        = true
#   security_group_ids = var.use_existing_security_groups ? var.existing_security_groups : [aws_security_group.this[0].id]
#   tags               = var.tags
# }

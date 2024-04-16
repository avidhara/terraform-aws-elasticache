module "redis" {
  source                        = "../../"
  name                          = "example"
  replication_group_description = "Example Redis Replication Group"
  availability_zones            = ["us-west-1b", "us-west-1c"]
  vpc_id                        = "vpc-0195ea97914a47b9c"
  allowed_security_groups       = []
  subnet_ids                    = ["subnet-0be04ef81f4b04b39", "subnet-02d90acada3f3ca14"]
  cluster_size                  = 1
  node_type                     = "cache.t3.micro"
  apply_immediately             = true
  automatic_failover_enabled    = false
  family                        = "redis6.x"
  at_rest_encryption_enabled    = false
  transit_encryption_enabled    = true
  parameter_group_name          = "default.redis7"
  allowed_cidr_blocks           = ["10.10.0.0/16"]
}

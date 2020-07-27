resource "aws_elasticache_replication_group" "redis" {
  count = var.enabled && var.engine == "redis" ? 1 : 0

  parameter_group_name  = var.parameter_group_name == "" ? join("", aws_elasticache_parameter_group.this.*.name) : var.parameter_group_name
  subnet_group_name     = var.subnet_group_name != "" ? var.subnet_group_name : aws_elasticache_subnet_group.this[0].name
  security_group_ids    = var.use_existing_security_groups ? var.existing_security_groups : [aws_security_group.this[0].id]
  availability_zones    = var.cluster_mode_enabled ? null : slice(var.availability_zones, 0, var.cluster_size)
  replication_group_id  = format("%s-redis", var.name)
  number_cache_clusters = var.cluster_mode_enabled ? null : var.cluster_size
  node_type             = var.node_type

  engine_version = var.engine_version
  port           = var.port

  maintenance_window         = var.maintenance_window
  snapshot_window            = var.snapshot_window
  snapshot_retention_limit   = var.snapshot_retention_limit
  automatic_failover_enabled   = var.cluster_mode_enabled ? true: var.automatic_failover_enabled
  auto_minor_version_upgrade = var.auto_minor_version_upgrade

  # snapshot_arns = var.snapshot_arns
  # snapshot_name = var.snapshot_name

  at_rest_encryption_enabled = var.at_rest_encryption_enabled
  transit_encryption_enabled = var.transit_encryption_enabled
  auth_token                 = var.auth_token != "" ? var.auth_token : null
  kms_key_id                 = var.kms_key_id

  apply_immediately = var.apply_immediately

  replication_group_description = var.replication_group_description

  notification_topic_arn = var.notification_topic_arn

  dynamic "cluster_mode" {
    for_each = var.cluster_mode_enabled ? ["true"] : []
    content {
      replicas_per_node_group = var.cluster_mode_replicas_per_node_group
      num_node_groups         = var.cluster_mode_num_node_groups
    }
  }
  tags = merge(
    {
      "Name" = "${var.name}-redis"
    },
    var.tags,
  )
}

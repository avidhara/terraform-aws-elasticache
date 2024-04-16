resource "aws_elasticache_replication_group" "this" {
  count = var.create ? 1 : 0

  description          = var.replication_group_description
  replication_group_id = format("%s-redis", var.name)

  apply_immediately           = var.apply_immediately
  at_rest_encryption_enabled  = var.at_rest_encryption_enabled
  auth_token                  = var.auth_token
  auth_token_update_strategy  = var.auth_token_update_strategy
  auto_minor_version_upgrade  = var.auto_minor_version_upgrade
  automatic_failover_enabled  = var.cluster_mode_enabled ? true : var.automatic_failover_enabled
  data_tiering_enabled        = var.data_tiering_enabled
  engine                      = var.engine
  engine_version              = var.engine_version
  final_snapshot_identifier   = var.final_snapshot_identifier
  global_replication_group_id = var.global_replication_group_id
  ip_discovery                = var.ip_discovery
  kms_key_id                  = var.at_rest_encryption_enabled ? var.kms_key_id : null

  dynamic "log_delivery_configuration" {
    for_each = var.log_delivery_configuration
    content {
      destination      = log_delivery_configuration.value.destination
      destination_type = log_delivery_configuration.value.destination_type
      log_format       = log_delivery_configuration.value.log_format
      log_type         = log_delivery_configuration.value.log_type
    }

  }

  maintenance_window          = var.maintenance_window
  multi_az_enabled            = var.multi_az_enabled
  network_type                = var.network_type
  node_type                   = var.node_type
  notification_topic_arn      = var.notification_topic_arn
  num_cache_clusters          = var.cluster_mode_enabled ? null : var.cluster_size
  num_node_groups             = var.cluster_mode_enabled ? var.num_node_groups : null
  parameter_group_name        = var.create_parameter_group ? aws_elasticache_parameter_group.this[0].name : var.parameter_group_name
  port                        = var.port
  preferred_cache_cluster_azs = length(var.availability_zones) == 0 ? null : [for n in range(0, var.cluster_size) : element(var.availability_zones, n)]

  replicas_per_node_group = var.cluster_mode_enabled ? var.replicas_per_node_group : null

  security_group_ids       = var.use_existing_security_groups ? var.existing_security_groups : [aws_security_group.this[0].id]
  snapshot_arns            = var.snapshot_arns
  snapshot_name            = var.snapshot_name
  snapshot_retention_limit = var.snapshot_retention_limit
  snapshot_window          = var.snapshot_window
  subnet_group_name        = var.subnet_group_name != "" ? var.subnet_group_name : aws_elasticache_subnet_group.this[0].name

  transit_encryption_enabled = var.transit_encryption_enabled

  tags = var.tags
}

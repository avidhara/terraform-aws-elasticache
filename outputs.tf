output "parameter_group_id" {
  description = "The ElastiCache parameter group name."
  value       = try(aws_elasticache_parameter_group.this[0].id, null)
}

output "id" {
  description = "The ID of the ElastiCache Replication Group"
  value       = try(aws_elasticache_replication_group.this[0].id, null)
}

output "configuration_endpoint_address" {
  description = "The address of the replication group configuration endpoint when cluster mode is enabled."
  value       = try(aws_elasticache_replication_group.this[0].configuration_endpoint_address, null)

}

output "primary_endpoint_address" {
  description = "(Redis only) The address of the endpoint for the primary node in the replication group, if the cluster mode is disabled."
  value       = try(aws_elasticache_replication_group.this[0].primary_endpoint_address, null)
}

output "cluster_enabled" {
  description = "Indicates if cluster mode is enabled."
  value       = try(aws_elasticache_replication_group.this[0].cluster_enabled, null)
}

output "engine_version_actual" {
  description = "Because ElastiCache pulls the latest minor or patch for a version, this attribute returns the running version of the cache engine."
  value       = try(aws_elasticache_replication_group.this[0].engine_version_actual, null)
}

output "security_group_id" {
  description = "Security group ID for the ElastiCache Replication Group"
  value       = try(aws_security_group.this[0].id, null)
}

output "subnet_group_id" {
  description = "Subnet group ID for the ElastiCache Replication Group"
  value       = try(aws_elasticache_subnet_group.this[0].id, null)
}

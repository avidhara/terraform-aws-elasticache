output "parameter_group_id" {
  description = "The ElastiCache parameter group name."
  value       = join("", aws_elasticache_parameter_group.this.*.name)
}

output "id" {
  description = "The ID of the ElastiCache Replication Group"
  value       = join("", aws_elasticache_replication_group.this.*.id)
}

output "configuration_endpoint_address" {

  description = "The address of the replication group configuration endpoint when cluster mode is enabled."
  value       = var.cluster_mode_enabled ? join("", aws_elasticache_replication_group.this.*.configuration_endpoint_address) : join("", aws_elasticache_replication_group.this.*.primary_endpoint_address)
}

output "primary_endpoint_address" {
  description = "(Redis only) The address of the endpoint for the primary node in the replication group, if the cluster mode is disabled."
  value       = var.engine == "redis" ? join("", aws_elasticache_replication_group.this.*.primary_endpoint_address) : ""
}


output "member_clusters" {
  description = "The identifiers of all the nodes that are part of this replication group."
  value       = join("", aws_elasticache_replication_group.this.*.member_clusters)
}

output "security_group_id" {
  value       = join("", aws_security_group.this.*.id)
  description = "Security group ID"
}
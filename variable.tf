variable "create" {
  type        = bool
  description = "(Optional) Do you want to create elastic cache service default is true"
  default     = true
}

variable "name" {
  type        = string
  description = "Name of the cluster"
}

variable "family" {
  type        = string
  description = "The family of the ElastiCache parameter group."
}

############# Parameter Group ########

variable "create_parameter_group" {
  type        = bool
  description = "(Optional) Do you want to create a parameter group for the ElastiCache cluster. Defaults to true."
  default     = false
}

variable "parameter_group_description" {
  type        = string
  description = "(Optional) The description of the ElastiCache parameter group. Defaults to 'Managed by Terraform'."
  default     = "Managed by Terraform"
}

variable "parameter_group_parameters" {
  type = list(object({
    name  = string
    value = string
  }))
  description = <<_EOT
  A list of parameter names and values that will be used in the parameter group.
  - name: The name of the parameter.
  - value: The value of the parameter.
  _EOT
  default     = []
}

########## Subnet Groups #####

variable "subnet_group_description" {
  type        = string
  description = "(Optional) Description for the cache subnet group. Defaults to 'Managed by Terraform'."
  default     = "Managed by Terraform"
}

variable "subnet_ids" {
  type        = list(string)
  description = "(Required) List of VPC Subnet IDs for the cache subnet group"
}

########## Security Groups #######

variable "use_existing_security_groups" {
  type        = bool
  description = "description"
  default     = false
}

variable "vpc_id" {
  type        = string
  description = "(Optional, Forces new resource) The VPC ID."
  default     = null
}

variable "allowed_security_groups" {
  type        = list(string)
  description = "List of Security Group IDs that are allowed ingress to the cluster's Security Group created in the module"
  default     = []
}

variable "allowed_cidr_blocks" {
  type        = list(string)
  description = "List of CIDR blocks that are allowed ingress to the cluster's Security Group created in the module"
  default     = []
}

variable "existing_security_groups" {
  type        = list(string)
  default     = []
  description = "List of existing Security Group IDs to place the cluster into. Set `use_existing_security_groups` to `true` to enable using `existing_security_groups` as Security Groups for the cluster"
}

########### Tags  ##########

variable "tags" {
  type        = map(string)
  description = "A map of tags to assign to the resource."
  default = {

  }
}

######## Elastic Cache #######

variable "replication_group_description" {
  type        = string
  description = "Required) User-created description for the replication group. Must not be empty."
}

variable "number_cache_clusters" {
  type        = number
  description = " (Required for Cluster Mode Disabled) The number of cache clusters (primary and replicas) this replication group will have. If Multi-AZ is enabled, the value of this parameter must be at least 2. Updates will occur before other modifications."
  default     = 0
}

variable "cluster_size" {
  type        = number
  default     = 1
  description = "Number of nodes in cluster. *Ignored when `cluster_mode_enabled` == `true`*"
}

variable "node_type" {
  type        = string
  description = "(Optional) Instance class to be used. See AWS documentation for information on supported node types and guidance on selecting node types. Required unless global_replication_group_id is set. Cannot be set if global_replication_group_id is set."
  default     = null
}

variable "num_cache_clusters" {
  type        = number
  description = "(Optional) Number of cache clusters (primary and replicas) this replication group will have. If Multi-AZ is enabled, the value of this parameter must be at least 2. Updates will occur before other modifications. Conflicts with num_node_groups. Defaults to 1."
  default     = 1
}

variable "num_node_groups" {
  type        = number
  description = "(Optional) Number of node groups (shards) for this Redis replication group. Changing this number will trigger a resizing operation before other settings modifications."
  default     = null
}

variable "automatic_failover_enabled" {
  type        = bool
  description = "(Optional) Specifies whether a read-only replica will be automatically promoted to read/write primary if the existing primary fails. If true, Multi-AZ is enabled for this replication group. If false, Multi-AZ is disabled for this replication group. Must be enabled for Redis (cluster mode enabled) replication groups. Defaults to false"
  default     = false
}

variable "auto_minor_version_upgrade" {
  type        = bool
  description = "(Optional) Specifies whether a minor engine upgrades will be applied automatically to the underlying Cache Cluster instances during the maintenance window. Defaults to true"
  default     = true
}

variable "data_tiering_enabled" {
  type        = bool
  description = "(Optional) Enables data tiering. Data tiering is only supported for replication groups using the r6gd node type. This parameter must be set to true when using r6gd nodes."
  default     = false
}

variable "availability_zones" {
  type        = list(string)
  description = "(Optional) A list of EC2 availability zones in which the replication group's cache clusters will be created. The order of the availability zones in the list is not important."
  default = [

  ]
}

variable "engine" {
  type        = string
  description = "(Optional) The name of the cache engine to be used for the clusters in this replication group. e.g. redis"
  default     = "redis"
}

variable "at_rest_encryption_enabled" {
  type        = bool
  description = "(Optional) Whether to enable encryption at rest."
  default     = false
}

variable "transit_encryption_enabled" {
  type        = bool
  description = "(Optional) Whether to enable encryption in transit"
  default     = false
}

variable "auth_token" {
  type        = string
  description = "(Optional) The password used to access a password protected server. Can be specified only if transit_encryption_enabled = true"
  default     = null
}

variable "auth_token_update_strategy" {
  type        = string
  description = "(Optional) Strategy to use when updating the auth_token. Valid values are SET, ROTATE, and DELETE. Defaults to ROTATE."
  default     = "ROTATE"
}

variable "engine_version" {
  type        = string
  description = "(Optional) The version number of the cache engine to be used for the cache clusters in this replication group."
  default     = null
}

variable "final_snapshot_identifier" {
  type        = string
  description = "(Optional) The name of your final node group (shard) snapshot. ElastiCache creates the snapshot from the primary node in the cluster. If omitted, no final snapshot will be made."
  default     = null
}

variable "global_replication_group_id" {
  type        = string
  description = "(Optional) The ID of the global replication group to which this replication group should belong. If this parameter is specified, the replication group is added to the specified global replication group as a secondary replication group; otherwise, the replication group is not part of any global replication group. If global_replication_group_id is set, the num_node_groups parameter cannot be set."
  default     = null
}

variable "ip_discovery" {
  type        = string
  description = "(Optional) The IP version to advertise in the discovery protocol. Valid values are ipv4 or ipv6."
  default     = "ipv4"
}

variable "kms_key_id" {
  type        = string
  description = "Optional) The ARN of the key that you wish to use if encrypting at rest. If not supplied, uses service managed encryption. Can be specified only if at_rest_encryption_enabled = true"
  default     = null
}

variable "log_delivery_configuration" {
  type = list(object({
    destination      = string
    destination_type = string
    log_format       = string
    log_type         = string
  }))
  description = <<_EOT
  A list of log delivery configurations for the replication group.
  - destination: The name of the S3 bucket to which the log data is written.
  - destination_type: The type of destination (currently only S3 is supported).
  - log_format: The log format to use. Valid values are json or text.
  - log_type: The type of log to deliver. Valid values are slowlog or error.
  _EOT
  default     = []
}

variable "maintenance_window" {
  type        = string
  description = "(Optional) Specifies the weekly time range for when maintenance on the cache cluster is performed. The format is ddd:hh24:mi-ddd:hh24:mi (24H Clock UTC). The minimum maintenance window is a 60 minute period. Example: sun:05:00-sun:09:00"
  default     = "wed:03:00-wed:04:00"
}

variable "multi_az_enabled" {
  type        = bool
  description = "(Optional) Specifies whether to enable Multi-AZ Support for the replication group. If true, automatic_failover_enabled must also be enabled. Defaults to false."
  default     = false
}

variable "network_type" {
  type        = string
  description = "(Optional) The IP versions for cache cluster connections. Valid values are ipv4, ipv6 or dual_stack."
  default     = "ipv4"
}

variable "parameter_group_name" {
  type        = string
  description = "(Optional) The name of the parameter group to associate with this replication group. If this argument is omitted, the default cache parameter group for the specified engine is used."
  default     = ""
}

variable "port" {
  type        = number
  description = "(Optional) The port number on which each of the cache nodes will accept connections. For Memcache the default is 11211, and for Redis the default port is 6379."
  default     = 6379
}

variable "replicas_per_node_group" {
  type        = number
  description = "(Optional) Number of replica nodes in each node group. Changing this number will trigger a resizing operation before other settings modifications. Valid values are 0 to 5."
  default     = null
}

variable "subnet_group_name" {
  type        = string
  description = "(Optional) The name of the cache subnet group to be used for the replication group."
  default     = ""
}

variable "security_group_ids" {
  type        = list(string)
  description = "(Optional) One or more Amazon VPC security groups associated with this replication group. Use this parameter only when you are creating a replication group in an Amazon Virtual Private Cloud"
  default = [

  ]
}

variable "snapshot_arns" {
  type        = list(string)
  description = "(Optional) A single-element string list containing an Amazon Resource Name (ARN) of a Redis RDB snapshot file stored in Amazon S3. Example: arn:aws:s3:::my_bucket/snapshot1.rdb"
  default     = null
}

variable "snapshot_name" {
  type        = string
  description = "(Optional) The name of a snapshot from which to restore data into the new node group. Changing the snapshot_name forces a new resource."
  default     = null
}

variable "notification_topic_arn" {
  type        = string
  description = "(Optional) An Amazon Resource Name (ARN) of an SNS topic to send ElastiCache notifications to. Example: arn:aws:sns:us-east-1:012345678999:my_sns_topic"
  default     = null
}

variable "snapshot_window" {
  type        = string
  description = "The daily time range (in UTC) during which ElastiCache will begin taking a daily snapshot of your cache cluster."
  default     = "06:30-07:30"
}

variable "snapshot_retention_limit" {
  type        = number
  description = "The number of days for which ElastiCache will retain automatic cache cluster snapshots before deleting them."
  default     = 0
}

variable "apply_immediately" {
  type        = bool
  description = "(Optional) Specifies whether any modifications are applied immediately, or during the next maintenance window. Default is false."
  default     = false
}

variable "cluster_mode_enabled" {
  type        = bool
  description = "(Optional) Flag to enable/disable creation of a native redis cluster. `automatic_failover_enabled` must be set to `true`. Only 1 `cluster_mode` block is allowed"
  default     = false
}

variable "user_group_ids" {
  type        = list(string)
  description = "(Optional) User Group ID to associate with the replication group. Only a maximum of one (1) user group ID is valid. NOTE: This argument is a set because the AWS specification allows for multiple IDs. However, in practice, AWS only allows a maximum size of one."
  default     = null
}

### VPC Endpoint ####
variable "create_vpc_endpoint" {
  type        = bool
  description = "(optional) Do you want to create VPC endpoint for ElastiCache default is false"
  default     = false
}

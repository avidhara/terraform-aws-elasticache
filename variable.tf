variable "enabled" {
  type        = bool
  description = "Do you want to create elastic cache service"
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
############# Par
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
  description = "(Required) The name of the ElastiCache parameter group."
  default = [

  ]
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



########### Tags 

variable "tags" {
  type        = map(string)
  description = "A map of tags to assign to the resource."
  default = {

  }
}


######## Elastic Cache #######

variable "replication_group_id" {
  type        = string
  description = "(Required) The replication group identifier. This parameter is stored as a lowercase string"
}

variable "replication_group_description" {
  type        = string
  description = "(Required) A user-created description for the replication group."
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
  description = "(Required) The compute and memory capacity of the nodes in the node group."
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
  description = " (Optional) The password used to access a password protected server. Can be specified only if transit_encryption_enabled = true"
  default     = null
}

variable "kms_key_id" {
  type        = string
  description = "Optional) The ARN of the key that you wish to use if encrypting at rest. If not supplied, uses service managed encryption. Can be specified only if at_rest_encryption_enabled = true"
  default     = null
}

variable "engine_version" {
  type        = string
  description = "(Optional) The version number of the cache engine to be used for the cache clusters in this replication group."
  default     = null
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
  type        = string
  description = "(Optional) A single-element string list containing an Amazon Resource Name (ARN) of a Redis RDB snapshot file stored in Amazon S3. Example: arn:aws:s3:::my_bucket/snapshot1.rdb"
  default     = ""
}

variable "snapshot_name" {
  type        = string
  description = "(Optional) The name of a snapshot from which to restore data into the new node group. Changing the snapshot_name forces a new resource."
  default     = ""
}

variable "maintenance_window" {
  type        = string
  description = "(Optional) Specifies the weekly time range for when maintenance on the cache cluster is performed. The format is ddd:hh24:mi-ddd:hh24:mi (24H Clock UTC). The minimum maintenance window is a 60 minute period. Example: sun:05:00-sun:09:00"
  default     = "wed:03:00-wed:04:00"
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
  description = "Apply changes immediately"
  default     = true

}

variable "cluster_mode_enabled" {
  type        = bool
  description = "Flag to enable/disable creation of a native redis cluster. `automatic_failover_enabled` must be set to `true`. Only 1 `cluster_mode` block is allowed"
  default     = false
}

variable "cluster_mode_replicas_per_node_group" {
  type        = number
  description = "Number of replica nodes in each node group. Valid values are 0 to 5. Changing this number will force a new resource"
  default     = 0
}

variable "cluster_mode_num_node_groups" {
  type        = number
  description = "Number of node groups (shards) for this Redis replication group. Changing this number will trigger an online resizing operation before other settings modifications"
  default     = 0
}

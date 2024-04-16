# Terraform module for for AWS ElastiCache

## Usage

```hcl
module "redis" {
  source = "../../"
  name = "example"
  replication_group_description = "Example Redis Replication Group"
  availability_zones               = ["us-west-1b", "us-west-1c"]
  vpc_id                           = "vpc-xxxx"
  allowed_security_groups          = []
  subnet_ids                          = ["subnet-xxx", "subnet-xxxx"]
  cluster_size                     = 1
  node_type                    = "cache.t3.micro"
  apply_immediately                = true
  automatic_failover_enabled       = false
  family = "redis6.x"
  at_rest_encryption_enabled       = false
  transit_encryption_enabled       = true
  parameter_group_name = "default.redis7"
  allowed_cidr_blocks = ["10.10.0.0/16"]
}

```
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.2 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.40 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.40 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_elasticache_parameter_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_parameter_group) | resource |
| [aws_elasticache_replication_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_replication_group) | resource |
| [aws_elasticache_subnet_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_subnet_group) | resource |
| [aws_security_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ingress_cidr_blocks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ingress_security_groups](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allowed_cidr_blocks"></a> [allowed\_cidr\_blocks](#input\_allowed\_cidr\_blocks) | List of CIDR blocks that are allowed ingress to the cluster's Security Group created in the module | `list(string)` | `[]` | no |
| <a name="input_allowed_security_groups"></a> [allowed\_security\_groups](#input\_allowed\_security\_groups) | List of Security Group IDs that are allowed ingress to the cluster's Security Group created in the module | `list(string)` | `[]` | no |
| <a name="input_apply_immediately"></a> [apply\_immediately](#input\_apply\_immediately) | (Optional) Specifies whether any modifications are applied immediately, or during the next maintenance window. Default is false. | `bool` | `false` | no |
| <a name="input_at_rest_encryption_enabled"></a> [at\_rest\_encryption\_enabled](#input\_at\_rest\_encryption\_enabled) | (Optional) Whether to enable encryption at rest. | `bool` | `false` | no |
| <a name="input_auth_token"></a> [auth\_token](#input\_auth\_token) | (Optional) The password used to access a password protected server. Can be specified only if transit\_encryption\_enabled = true | `string` | `null` | no |
| <a name="input_auth_token_update_strategy"></a> [auth\_token\_update\_strategy](#input\_auth\_token\_update\_strategy) | (Optional) Strategy to use when updating the auth\_token. Valid values are SET, ROTATE, and DELETE. Defaults to ROTATE. | `string` | `"ROTATE"` | no |
| <a name="input_auto_minor_version_upgrade"></a> [auto\_minor\_version\_upgrade](#input\_auto\_minor\_version\_upgrade) | (Optional) Specifies whether a minor engine upgrades will be applied automatically to the underlying Cache Cluster instances during the maintenance window. Defaults to true | `bool` | `true` | no |
| <a name="input_automatic_failover_enabled"></a> [automatic\_failover\_enabled](#input\_automatic\_failover\_enabled) | (Optional) Specifies whether a read-only replica will be automatically promoted to read/write primary if the existing primary fails. If true, Multi-AZ is enabled for this replication group. If false, Multi-AZ is disabled for this replication group. Must be enabled for Redis (cluster mode enabled) replication groups. Defaults to false | `bool` | `false` | no |
| <a name="input_availability_zones"></a> [availability\_zones](#input\_availability\_zones) | (Optional) A list of EC2 availability zones in which the replication group's cache clusters will be created. The order of the availability zones in the list is not important. | `list(string)` | `[]` | no |
| <a name="input_cluster_mode_enabled"></a> [cluster\_mode\_enabled](#input\_cluster\_mode\_enabled) | (Optional) Flag to enable/disable creation of a native redis cluster. `automatic_failover_enabled` must be set to `true`. Only 1 `cluster_mode` block is allowed | `bool` | `false` | no |
| <a name="input_cluster_size"></a> [cluster\_size](#input\_cluster\_size) | Number of nodes in cluster. *Ignored when `cluster_mode_enabled` == `true`* | `number` | `1` | no |
| <a name="input_create"></a> [create](#input\_create) | (Optional) Do you want to create elastic cache service default is true | `bool` | `true` | no |
| <a name="input_create_parameter_group"></a> [create\_parameter\_group](#input\_create\_parameter\_group) | (Optional) Do you want to create a parameter group for the ElastiCache cluster. Defaults to true. | `bool` | `false` | no |
| <a name="input_create_vpc_endpoint"></a> [create\_vpc\_endpoint](#input\_create\_vpc\_endpoint) | (optional) Do you want to create VPC endpoint for ElastiCache default is false | `bool` | `false` | no |
| <a name="input_data_tiering_enabled"></a> [data\_tiering\_enabled](#input\_data\_tiering\_enabled) | (Optional) Enables data tiering. Data tiering is only supported for replication groups using the r6gd node type. This parameter must be set to true when using r6gd nodes. | `bool` | `false` | no |
| <a name="input_engine"></a> [engine](#input\_engine) | (Optional) The name of the cache engine to be used for the clusters in this replication group. e.g. redis | `string` | `"redis"` | no |
| <a name="input_engine_version"></a> [engine\_version](#input\_engine\_version) | (Optional) The version number of the cache engine to be used for the cache clusters in this replication group. | `string` | `null` | no |
| <a name="input_existing_security_groups"></a> [existing\_security\_groups](#input\_existing\_security\_groups) | List of existing Security Group IDs to place the cluster into. Set `use_existing_security_groups` to `true` to enable using `existing_security_groups` as Security Groups for the cluster | `list(string)` | `[]` | no |
| <a name="input_family"></a> [family](#input\_family) | The family of the ElastiCache parameter group. | `string` | n/a | yes |
| <a name="input_final_snapshot_identifier"></a> [final\_snapshot\_identifier](#input\_final\_snapshot\_identifier) | (Optional) The name of your final node group (shard) snapshot. ElastiCache creates the snapshot from the primary node in the cluster. If omitted, no final snapshot will be made. | `string` | `null` | no |
| <a name="input_global_replication_group_id"></a> [global\_replication\_group\_id](#input\_global\_replication\_group\_id) | (Optional) The ID of the global replication group to which this replication group should belong. If this parameter is specified, the replication group is added to the specified global replication group as a secondary replication group; otherwise, the replication group is not part of any global replication group. If global\_replication\_group\_id is set, the num\_node\_groups parameter cannot be set. | `string` | `null` | no |
| <a name="input_ip_discovery"></a> [ip\_discovery](#input\_ip\_discovery) | (Optional) The IP version to advertise in the discovery protocol. Valid values are ipv4 or ipv6. | `string` | `"ipv4"` | no |
| <a name="input_kms_key_id"></a> [kms\_key\_id](#input\_kms\_key\_id) | Optional) The ARN of the key that you wish to use if encrypting at rest. If not supplied, uses service managed encryption. Can be specified only if at\_rest\_encryption\_enabled = true | `string` | `null` | no |
| <a name="input_log_delivery_configuration"></a> [log\_delivery\_configuration](#input\_log\_delivery\_configuration) | A list of log delivery configurations for the replication group.<br>  - destination: The name of the S3 bucket to which the log data is written.<br>  - destination\_type: The type of destination (currently only S3 is supported).<br>  - log\_format: The log format to use. Valid values are json or text.<br>  - log\_type: The type of log to deliver. Valid values are slowlog or error. | <pre>list(object({<br>    destination      = string<br>    destination_type = string<br>    log_format       = string<br>    log_type         = string<br>  }))</pre> | `[]` | no |
| <a name="input_maintenance_window"></a> [maintenance\_window](#input\_maintenance\_window) | (Optional) Specifies the weekly time range for when maintenance on the cache cluster is performed. The format is ddd:hh24:mi-ddd:hh24:mi (24H Clock UTC). The minimum maintenance window is a 60 minute period. Example: sun:05:00-sun:09:00 | `string` | `"wed:03:00-wed:04:00"` | no |
| <a name="input_multi_az_enabled"></a> [multi\_az\_enabled](#input\_multi\_az\_enabled) | (Optional) Specifies whether to enable Multi-AZ Support for the replication group. If true, automatic\_failover\_enabled must also be enabled. Defaults to false. | `bool` | `false` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the cluster | `string` | n/a | yes |
| <a name="input_network_type"></a> [network\_type](#input\_network\_type) | (Optional) The IP versions for cache cluster connections. Valid values are ipv4, ipv6 or dual\_stack. | `string` | `"ipv4"` | no |
| <a name="input_node_type"></a> [node\_type](#input\_node\_type) | (Optional) Instance class to be used. See AWS documentation for information on supported node types and guidance on selecting node types. Required unless global\_replication\_group\_id is set. Cannot be set if global\_replication\_group\_id is set. | `string` | `null` | no |
| <a name="input_notification_topic_arn"></a> [notification\_topic\_arn](#input\_notification\_topic\_arn) | (Optional) An Amazon Resource Name (ARN) of an SNS topic to send ElastiCache notifications to. Example: arn:aws:sns:us-east-1:012345678999:my\_sns\_topic | `string` | `null` | no |
| <a name="input_num_cache_clusters"></a> [num\_cache\_clusters](#input\_num\_cache\_clusters) | (Optional) Number of cache clusters (primary and replicas) this replication group will have. If Multi-AZ is enabled, the value of this parameter must be at least 2. Updates will occur before other modifications. Conflicts with num\_node\_groups. Defaults to 1. | `number` | `1` | no |
| <a name="input_num_node_groups"></a> [num\_node\_groups](#input\_num\_node\_groups) | (Optional) Number of node groups (shards) for this Redis replication group. Changing this number will trigger a resizing operation before other settings modifications. | `number` | `null` | no |
| <a name="input_number_cache_clusters"></a> [number\_cache\_clusters](#input\_number\_cache\_clusters) | (Required for Cluster Mode Disabled) The number of cache clusters (primary and replicas) this replication group will have. If Multi-AZ is enabled, the value of this parameter must be at least 2. Updates will occur before other modifications. | `number` | `0` | no |
| <a name="input_parameter_group_description"></a> [parameter\_group\_description](#input\_parameter\_group\_description) | (Optional) The description of the ElastiCache parameter group. Defaults to 'Managed by Terraform'. | `string` | `"Managed by Terraform"` | no |
| <a name="input_parameter_group_name"></a> [parameter\_group\_name](#input\_parameter\_group\_name) | (Optional) The name of the parameter group to associate with this replication group. If this argument is omitted, the default cache parameter group for the specified engine is used. | `string` | `""` | no |
| <a name="input_parameter_group_parameters"></a> [parameter\_group\_parameters](#input\_parameter\_group\_parameters) | A list of parameter names and values that will be used in the parameter group.<br>  - name: The name of the parameter.<br>  - value: The value of the parameter. | <pre>list(object({<br>    name  = string<br>    value = string<br>  }))</pre> | `[]` | no |
| <a name="input_port"></a> [port](#input\_port) | (Optional) The port number on which each of the cache nodes will accept connections. For Memcache the default is 11211, and for Redis the default port is 6379. | `number` | `6379` | no |
| <a name="input_replicas_per_node_group"></a> [replicas\_per\_node\_group](#input\_replicas\_per\_node\_group) | (Optional) Number of replica nodes in each node group. Changing this number will trigger a resizing operation before other settings modifications. Valid values are 0 to 5. | `number` | `null` | no |
| <a name="input_replication_group_description"></a> [replication\_group\_description](#input\_replication\_group\_description) | Required) User-created description for the replication group. Must not be empty. | `string` | n/a | yes |
| <a name="input_security_group_ids"></a> [security\_group\_ids](#input\_security\_group\_ids) | (Optional) One or more Amazon VPC security groups associated with this replication group. Use this parameter only when you are creating a replication group in an Amazon Virtual Private Cloud | `list(string)` | `[]` | no |
| <a name="input_snapshot_arns"></a> [snapshot\_arns](#input\_snapshot\_arns) | (Optional) A single-element string list containing an Amazon Resource Name (ARN) of a Redis RDB snapshot file stored in Amazon S3. Example: arn:aws:s3:::my\_bucket/snapshot1.rdb | `list(string)` | `null` | no |
| <a name="input_snapshot_name"></a> [snapshot\_name](#input\_snapshot\_name) | (Optional) The name of a snapshot from which to restore data into the new node group. Changing the snapshot\_name forces a new resource. | `string` | `null` | no |
| <a name="input_snapshot_retention_limit"></a> [snapshot\_retention\_limit](#input\_snapshot\_retention\_limit) | The number of days for which ElastiCache will retain automatic cache cluster snapshots before deleting them. | `number` | `0` | no |
| <a name="input_snapshot_window"></a> [snapshot\_window](#input\_snapshot\_window) | The daily time range (in UTC) during which ElastiCache will begin taking a daily snapshot of your cache cluster. | `string` | `"06:30-07:30"` | no |
| <a name="input_subnet_group_description"></a> [subnet\_group\_description](#input\_subnet\_group\_description) | (Optional) Description for the cache subnet group. Defaults to 'Managed by Terraform'. | `string` | `"Managed by Terraform"` | no |
| <a name="input_subnet_group_name"></a> [subnet\_group\_name](#input\_subnet\_group\_name) | (Optional) The name of the cache subnet group to be used for the replication group. | `string` | `""` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | (Required) List of VPC Subnet IDs for the cache subnet group | `list(string)` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to assign to the resource. | `map(string)` | `{}` | no |
| <a name="input_transit_encryption_enabled"></a> [transit\_encryption\_enabled](#input\_transit\_encryption\_enabled) | (Optional) Whether to enable encryption in transit | `bool` | `false` | no |
| <a name="input_use_existing_security_groups"></a> [use\_existing\_security\_groups](#input\_use\_existing\_security\_groups) | description | `bool` | `false` | no |
| <a name="input_user_group_ids"></a> [user\_group\_ids](#input\_user\_group\_ids) | (Optional) User Group ID to associate with the replication group. Only a maximum of one (1) user group ID is valid. NOTE: This argument is a set because the AWS specification allows for multiple IDs. However, in practice, AWS only allows a maximum size of one. | `list(string)` | `null` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | (Optional, Forces new resource) The VPC ID. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_enabled"></a> [cluster\_enabled](#output\_cluster\_enabled) | Indicates if cluster mode is enabled. |
| <a name="output_configuration_endpoint_address"></a> [configuration\_endpoint\_address](#output\_configuration\_endpoint\_address) | The address of the replication group configuration endpoint when cluster mode is enabled. |
| <a name="output_engine_version_actual"></a> [engine\_version\_actual](#output\_engine\_version\_actual) | Because ElastiCache pulls the latest minor or patch for a version, this attribute returns the running version of the cache engine. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the ElastiCache Replication Group |
| <a name="output_parameter_group_id"></a> [parameter\_group\_id](#output\_parameter\_group\_id) | The ElastiCache parameter group name. |
| <a name="output_primary_endpoint_address"></a> [primary\_endpoint\_address](#output\_primary\_endpoint\_address) | (Redis only) The address of the endpoint for the primary node in the replication group, if the cluster mode is disabled. |
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | Security group ID for the ElastiCache Replication Group |
| <a name="output_subnet_group_id"></a> [subnet\_group\_id](#output\_subnet\_group\_id) | Subnet group ID for the ElastiCache Replication Group |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

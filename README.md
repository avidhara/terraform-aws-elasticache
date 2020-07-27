# Terraform IAC for AWS ElastiCache

## Prerequisites

- Terraform 0.12.x
- aws cli

## Usage

```hcl
module "redis_cache" {
    source = "./"
    name   = "redis5"
    family = "redis5.0"
    parameter_group_parameters = [
    {
        name  = "activerehashing"
        value = "yes"
    },
    {
        name  = "cluster-enabled"
        value = "yes"
    }
    ]
    subnet_ids = ["subnet-******","subnet-******","subnet-******"]
    vpc_id = "vpc-****"

    allowed_security_groups = [
    "sg-******"
    ]
    allowed_cidr_blocks = [
    "10.0.0.0/16"
    ]
    replication_group_id          = "redis-test"
    replication_group_description = "test redis cluster"
    node_type                     = "cache.t2.medium"

    availability_zones                   = ["us-west-2a", "us-west-2b", "us-west-2c"]
    automatic_failover_enabled           = true
    engine                               = "redis"
    engine_version                       = "5.0.6"
    cluster_mode_enabled                 = true
    cluster_mode_replicas_per_node_group = 2
    cluster_mode_num_node_groups         = 3
  
}
```
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| aws | > 2.14.0 |

## Providers

| Name | Version |
|------|---------|
| aws | > 2.14.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| allowed\_cidr\_blocks | List of CIDR blocks that are allowed ingress to the cluster's Security Group created in the module | `list(string)` | `[]` | no |
| allowed\_security\_groups | List of Security Group IDs that are allowed ingress to the cluster's Security Group created in the module | `list(string)` | `[]` | no |
| apply\_immediately | Apply changes immediately | `bool` | `true` | no |
| at\_rest\_encryption\_enabled | (Optional) Whether to enable encryption at rest. | `bool` | `false` | no |
| auth\_token | (Optional) The password used to access a password protected server. Can be specified only if transit\_encryption\_enabled = true | `string` | `null` | no |
| auto\_minor\_version\_upgrade | (Optional) Specifies whether a minor engine upgrades will be applied automatically to the underlying Cache Cluster instances during the maintenance window. Defaults to true | `bool` | `true` | no |
| automatic\_failover\_enabled | (Optional) Specifies whether a read-only replica will be automatically promoted to read/write primary if the existing primary fails. If true, Multi-AZ is enabled for this replication group. If false, Multi-AZ is disabled for this replication group. Must be enabled for Redis (cluster mode enabled) replication groups. Defaults to false | `bool` | `false` | no |
| availability\_zones | (Optional) A list of EC2 availability zones in which the replication group's cache clusters will be created. The order of the availability zones in the list is not important. | `list(string)` | `[]` | no |
| cluster\_mode\_enabled | Flag to enable/disable creation of a native redis cluster. `automatic_failover_enabled` must be set to `true`. Only 1 `cluster_mode` block is allowed | `bool` | `false` | no |
| cluster\_mode\_num\_node\_groups | Number of node groups (shards) for this Redis replication group. Changing this number will trigger an online resizing operation before other settings modifications | `number` | `0` | no |
| cluster\_mode\_replicas\_per\_node\_group | Number of replica nodes in each node group. Valid values are 0 to 5. Changing this number will force a new resource | `number` | `0` | no |
| cluster\_size | Number of nodes in cluster. \*Ignored when `cluster_mode_enabled` == `true`\* | `number` | `1` | no |
| enabled | Do you want to create elastic cache service | `bool` | `true` | no |
| engine | (Optional) The name of the cache engine to be used for the clusters in this replication group. e.g. redis | `string` | `"redis"` | no |
| engine\_version | (Optional) The version number of the cache engine to be used for the cache clusters in this replication group. | `string` | `null` | no |
| existing\_security\_groups | List of existing Security Group IDs to place the cluster into. Set `use_existing_security_groups` to `true` to enable using `existing_security_groups` as Security Groups for the cluster | `list(string)` | `[]` | no |
| family | The family of the ElastiCache parameter group. | `string` | n/a | yes |
| kms\_key\_id | Optional) The ARN of the key that you wish to use if encrypting at rest. If not supplied, uses service managed encryption. Can be specified only if at\_rest\_encryption\_enabled = true | `string` | `null` | no |
| maintenance\_window | (Optional) Specifies the weekly time range for when maintenance on the cache cluster is performed. The format is ddd:hh24:mi-ddd:hh24:mi (24H Clock UTC). The minimum maintenance window is a 60 minute period. Example: sun:05:00-sun:09:00 | `string` | `"wed:03:00-wed:04:00"` | no |
| name | Name of the cluster | `string` | n/a | yes |
| node\_type | (Required) The compute and memory capacity of the nodes in the node group. | `string` | `null` | no |
| notification\_topic\_arn | (Optional) An Amazon Resource Name (ARN) of an SNS topic to send ElastiCache notifications to. Example: arn:aws:sns:us-east-1:012345678999:my\_sns\_topic | `string` | `null` | no |
| number\_cache\_clusters | (Required for Cluster Mode Disabled) The number of cache clusters (primary and replicas) this replication group will have. If Multi-AZ is enabled, the value of this parameter must be at least 2. Updates will occur before other modifications. | `number` | `0` | no |
| parameter\_group\_description | (Optional) The description of the ElastiCache parameter group. Defaults to 'Managed by Terraform'. | `string` | `"Managed by Terraform"` | no |
| parameter\_group\_name | (Optional) The name of the parameter group to associate with this replication group. If this argument is omitted, the default cache parameter group for the specified engine is used. | `string` | `""` | no |
| parameter\_group\_parameters | (Required) The name of the ElastiCache parameter group. | <pre>list(object({<br>    name  = string<br>    value = string<br>  }))</pre> | `[]` | no |
| port | (Optional) The port number on which each of the cache nodes will accept connections. For Memcache the default is 11211, and for Redis the default port is 6379. | `number` | `6379` | no |
| profile | n/a | `string` | `"default"` | no |
| region | n/a | `string` | `"us-west-2"` | no |
| replication\_group\_description | (Required) A user-created description for the replication group. | `string` | n/a | yes |
| replication\_group\_id | (Required) The replication group identifier. This parameter is stored as a lowercase string | `string` | n/a | yes |
| security\_group\_ids | (Optional) One or more Amazon VPC security groups associated with this replication group. Use this parameter only when you are creating a replication group in an Amazon Virtual Private Cloud | `list(string)` | `[]` | no |
| shared\_credentials\_file | n/a | `string` | `"/Users/rajeev/.aws/credentials"` | no |
| snapshot\_arns | (Optional) A single-element string list containing an Amazon Resource Name (ARN) of a Redis RDB snapshot file stored in Amazon S3. Example: arn:aws:s3:::my\_bucket/snapshot1.rdb | `string` | `""` | no |
| snapshot\_name | (Optional) The name of a snapshot from which to restore data into the new node group. Changing the snapshot\_name forces a new resource. | `string` | `""` | no |
| snapshot\_retention\_limit | The number of days for which ElastiCache will retain automatic cache cluster snapshots before deleting them. | `number` | `0` | no |
| snapshot\_window | The daily time range (in UTC) during which ElastiCache will begin taking a daily snapshot of your cache cluster. | `string` | `"06:30-07:30"` | no |
| subnet\_group\_description | (Optional) Description for the cache subnet group. Defaults to 'Managed by Terraform'. | `string` | `"Managed by Terraform"` | no |
| subnet\_group\_name | (Optional) The name of the cache subnet group to be used for the replication group. | `string` | `""` | no |
| subnet\_ids | (Required) List of VPC Subnet IDs for the cache subnet group | `list(string)` | n/a | yes |
| tags | A map of tags to assign to the resource. | `map(string)` | `{}` | no |
| transit\_encryption\_enabled | (Optional) Whether to enable encryption in transit | `bool` | `false` | no |
| use\_existing\_security\_groups | description | `bool` | `false` | no |
| vpc\_id | (Optional, Forces new resource) The VPC ID. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| configuration\_endpoint\_address | The address of the replication group configuration endpoint when cluster mode is enabled. |
| id | The ID of the ElastiCache Replication Group |
| member\_clusters | The identifiers of all the nodes that are part of this replication group. |
| parameter\_group\_id | The ElastiCache parameter group name. |
| primary\_endpoint\_address | (Redis only) The address of the endpoint for the primary node in the replication group, if the cluster mode is disabled. |
| security\_group\_id | Security group ID |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## ToDo
- [ ] Working with snapshot backups
- [ ] Update Module to support memcache 
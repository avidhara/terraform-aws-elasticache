resource "aws_elasticache_parameter_group" "this" {
  count = var.create_parameter_group && var.create ? 1 : 0

  name        = var.parameter_group_name
  description = var.parameter_group_description
  family      = var.family


  dynamic "parameter" {


    for_each = var.cluster_mode_enabled ? concat([{ name = "cluster-enabled", value = "yes" }], var.parameter_group_parameters) : var.parameter_group_parameters
    content {
      name  = parameter.value.name
      value = tostring(parameter.value.value)
    }
  }

  tags = var.tags
}

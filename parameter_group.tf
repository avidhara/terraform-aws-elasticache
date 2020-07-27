resource "aws_elasticache_parameter_group" "this" {
  count       = length(var.parameter_group_parameters) > 0 && var.enabled && var.parameter_group_name == "" ? 1 : 0
  name        = format("%s-params-group", var.name)
  description = var.parameter_group_description
  family      = var.family


  dynamic "parameter" {
    for_each = var.parameter_group_parameters
    content {
      name  = parameter.value["name"]
      value = parameter.value["value"]
    }
  }
}

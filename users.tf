# resource "aws_elasticache_user" "this" {
#     for_each = var.users
#   user_id       = each.value.user_id
#   user_name     = each.value.user_name
#   access_string = each.value.access_string
#   engine        = "REDIS"
#     no_password_required = each.value.no_password_required
#     passwords  = each.value.passwords

#     dynamic "authentication_mode" {
#         for_each = each.value.authentication_mode
#         content {
#             type = authentication_mode.value.type
#             password = authentication_mode.value.password
#         }

#     }
# }
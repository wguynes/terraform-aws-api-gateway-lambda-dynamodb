resource "aws_dynamodb_table" "table" {
  count                       = length(var.dynamodb_table_properties)
  name                        = lookup(var.dynamodb_table_properties[count.index], "name")
  read_capacity               = lookup(var.dynamodb_table_properties[count.index], "read_capacity", "1")
  write_capacity              = lookup(var.dynamodb_table_properties[count.index], "write_capacity", "1")
  hash_key                    = lookup(var.dynamodb_table_properties[count.index], "hash_key")
  range_key                   = lookup(var.dynamodb_table_properties[count.index], "range_key", "")
  stream_enabled              = lookup(var.dynamodb_table_properties[count.index], "stream_enabled", "")
  stream_view_type            = lookup(var.dynamodb_table_properties[count.index], "stream_view_type", "")

  dynamic "attribute" {
    for_each = var.dynamodb_table_attributes[count.index]
    content {
      name = attribute.value.name
      type = attribute.value.type
    }
  }

  global_secondary_index {
    name = "GameTitleIndex"
    hash_key = "GameTitle"
    range_key = "TopScore"
    write_capacity = 10
    read_capacity = 10
    projection_type = "INCLUDE"
    non_key_attributes = ["UserId"]
  }

  tags                        = var.tags
}
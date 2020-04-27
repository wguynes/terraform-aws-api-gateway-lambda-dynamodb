#TAGS
variable "tags" {
  type = map(string)
  description = "Tags for lambda"
  default = {}
}

#Setup
variable "dynamodb_table_properties" {
  type = list(map(string))
  description = "List of maps representing a table each. name (required), read_capacity(default=1), write_capacity(default=1), attributes(list), hash_key(required)"
}

variable "dynamodb_table_attributes" {
  type = list(list(map(string)))
  description = "List of maps representing each table attributes list. Required due to current HCL limitations"
}

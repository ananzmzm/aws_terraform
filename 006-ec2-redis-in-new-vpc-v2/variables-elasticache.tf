# Variable declarations
variable "ec_cluster_description" {
  description = "Describe the cluster you want to create."
  type = string
  default = "redis cluster by terraform"
}
variable "ec_cluster_name" {
  description = "Give me your ElastiCache cluster name."
  type = string
  default = "kyoungy-redis-tf"
}

variable "ec_node_type" {
  type = string
  default = "cache.t3.small"
}

variable "ec_number_of_nodes" {
  description = "Number of cache nodes."
  type = number
  default = 2
}

variable "ec_engine_version" {
  description = "When engine is redis and the version is 6 or higher, only the major version can be set, e.g., 6.x, otherwise, specify the full version desired, e.g., 5.0.6"
  type = string
  default = "6.x"
}

#variable "ec_parameter_group" {
#  description = "Select a parameter group: [default.redis6.x, default.redis5.0, default.redis4.0, default.redis3.2]"
#  type = string
#}
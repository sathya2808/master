variable "region" {
  description = "AWS Region, e.g us-west-2"
}

variable "name" {
  default = ""
}

variable "application" {
  default = ""
}

variable "environment" {
  description = "Environment tag, e.g staging"
}

variable "instance_profile" {}

variable "spot_percentage" {}

variable "common_security_group" {
  type = "list"
}

variable "key_name" {}

variable "vpc_id" {}

variable "app_private_subnet_ids" {
  type = "list"
}

variable "userdata" {}

variable "lb_private_subnet_ids" {
  type = "list"
}
variable "elb_healthcheck_path" {}
variable "internal_zone_id" {}
variable "dns_record_name" {}

variable "lb_private_security_group" {
  type = "list"
}

variable "ami_name_pattern" {}
variable "instance_port" {}

variable "connection_drain_timeout" {}

variable "tg_port" {}


variable "alb_healthcheck_path" {}

variable "instance_protocol" {}
variable "lb_port" {}
variable "lb_protocol" {}
variable "internal_status" {}

variable "instance_types_ondemand" {}

variable "instance_types_spot" {
  type = "list"
}

variable "web_private_subnet_ids" {
  type = "list"
}

variable "availability_zones" {
  description = "AWS available zones"
	type = "list"
}

variable "acp_min_size" {
	description = "Minimum number of instances"
}

variable "acp_max_size" {
	description = "Maximum number of instance"
}

variable "termination_policies" {
	description = "Instance termination policy"
  type = "list"
}

variable "enabled_metrics" {
	description = "ASG metrics"
	type = "list"
}


variable "billing_unit" {
	description = "Billing unit tag"
  type = "string"
}

variable "block_device_name" {
    description = "EC2 block device name"
    type = "string"
}

#variable "capacity_reservation_preference" {
#}

variable "core_count" {
}
variable "threads_per_core" {
}
#variable "cpu_credits" {
#
#}
variable "instance_initiated_shutdown_behavior" {
}

variable "db_private_subnet_ids" {
  type = "string"
}

variable "external_zone_id" {
  
}

variable "lb_public_security_group" {
  type = "list"
}
variable "cert_acm_arn" {
  
}

variable "lb_public_subnet_ids" {
  type = "list"
}

variable "ami_name_regex" {  
}

variable "market_type" {
  type = "string"
  default = "spot"
}

variable "acp_insta_type"{}

variable "health_check_type"{

}


variable "health_check_grace_period" {}

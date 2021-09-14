terragrunt = {
  include {
    path = "${find_in_parent_folders("common.tfvars")}"
  }
}

### Service variables
name = "stack_id-cep"
application = "stack_id-cep"
ami_name_pattern = "pt_rc_be_complex-event-processing*"
ami_name_regex = "^pt_rc_be_complex-event-processing"
instance_profile = "rc-stage-jenkins-role"


## Load Balancer parameters
instance_port = 8080
instance_protocol = "TCP"
lb_port = 80
lb_protocol = "TCP"
elb_healthcheck_path = "TCP:8080"
internal_status = "true"
connection_drain_timeout = 300
internal_lb_value = "true"

## R53 parameters
dns_record_name = "stack_id-cep.stage-rc.in."


#ASG variables
termination_policies = ["OldestLaunchConfiguration", "Default"]
health_check_type       = "EC2"
health_check_grace_period = "300"
enabled_metrics = ["GroupMinSize", "GroupMaxSize", "GroupDesiredCapacity", "GroupInServiceInstances", "GroupPendingInstances", "GroupStandbyInstances", "GroupTerminatingInstances", "GroupTotalInstances"]

#launch template variables
block_device_name = "/dev/sda1"
#capacity_reservation_preference = "open"
core_count = 4
#cpu_credits = "standard"
instance_initiated_shutdown_behavior = "terminate"
max_size = 3
min_size = 1
threads_per_core = 2
market_type = "on-demand"
insta_type= "m4.large"

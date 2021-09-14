terragrunt = {
  include {
    path = "${find_in_parent_folders("common.tfvars")}"
  }
}

### Service varibles
name = "stack_id-limit"
application = "stack_id-limit"
ami_name_pattern = "pt_rc_be_add-cash-limit*"
ami_name_regex   = "^pt_rc_be_add-cash-limit"


## Load Balancer parameters
lb_port = 80
lb_port1 = 443
lb_protocol = "HTTP"
alb_healthcheck_path = "/limitservice/userdetail/maxUserId"
internal_status = "true"
tg_port = "8080"
connection_drain_timeout = 300

## R53 parameters
dns_record_name = "stack_id-limitservice.stage-rc.in."


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
insta_type= "c4.large"
instance_profile = "rc-stage-jenkins-role"

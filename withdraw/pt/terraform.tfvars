terragrunt = {
  include {
    path = "${find_in_parent_folders("common.tfvars")}"
  }
}

### Service varibles
name = "stack_id-withdraw"
application = "stack_id-withdraw"
ami_name_pattern = "pt_rc_be_withdraw*"
ami_name_regex   = "^pt_rc_be_withdraw"


## Load Balancer parameters
instance_port = 8080
instance_protocol = "HTTP"
lb_port = 80
lb_protocol = "HTTP"
elb_healthcheck_path = "TCP:8080"
internal_status = "true"
connection_drain_timeout = 300

## Load Balancer parameters
tg_port = 8080
alb_healthcheck_path = "/withdraw_service/api/bankdetails/banknames?userId=241&channelId=1"

## R53 parameters
dns_record_name = "stack_id-ws.stage-rc.in"


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
max_size = 2
min_size = 1
threads_per_core = 2
insta_type= "m4.xlarge"
instance_profile = "rc-stage-jenkins-role"

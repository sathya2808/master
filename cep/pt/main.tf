data "aws_ami" "ami" {
  most_recent = true
  owners      = ["self"]

  filter {
    name   = "name"
    values = ["${var.ami_name_pattern}"]
  }
}


module "asg_cep" {
    source                  = "../../../../modules/custom_aws_asg_spot_elb"
    name                    = "${var.name}"
    availability_zones      = "${var.availability_zones}"
    vpc_zone_identifier     = "${var.app_private_subnet_ids}"
    min_size                = "${var.cep_min_size}"
    max_size                = "${var.cep_max_size}"
    enabled_metrics         = "${var.enabled_metrics}"
    termination_policies    = "${var.termination_policies}"
    launch_template_id      = "${module.launch_template.launch_template_id}"
    environment             = "${var.environment}"
    launch_template_version = "${module.launch_template.launch_template_version}"
    billing_unit            = "${var.billing_unit}"
    on_demand_percentage    = "${var.market_type !="spot" ? 100 : 0}"
    health_check_type         = "${var.health_check_type}" 
    health_check_grace_period = "${var.health_check_grace_period}"
}

module "asg_lifecycle_hook" {
  source = "../../../../modules/custom_aws_lifecycle_hook"
  name                      = "${var.name}-asg-lifecyclehook"
  autoscaling_group_name    = "${module.asg_cep.asg_arn}"
  default_result            = "CONTINUE"
  lifecycle_transition      = "autoscaling:EC2_INSTANCE_TERMINATING"
  heartbeat_timeout         = 600
} 

module "launch_template" {
  source                                = "../../../../modules/custom_aws_lt"
  name                                  = "${var.name}"  
  block_device_name                     = "${var.block_device_name}"
  #capacity_reservation_preference       = "${var.capacity_reservation_preference}"
  image_id                              = "${data.aws_ami.ami.id}"
  instance_type                         = "${var.cep_insta_type}"
  availability_zones                    = "${var.availability_zones}"
  key_name                              = "${var.key_name}"
  instance_initiated_shutdown_behavior  = "${var.instance_initiated_shutdown_behavior}"
  vpc_security_group_ids                = "${var.common_security_group}"
  #cpu_credits                           = "${var.cpu_credits}"
  userdata                              = "${base64encode(data.template_file.main.rendered)}"
  iam_instance_profile_name             = "${var.instance_profile}"

}

data "template_file" "main" {
  template = "${file("userdata.sh")}"
}

module "elb" {
  source                       = "../../../../modules/custom_elb_tcp"
  environment                  = "${var.environment}"
  name                         = "${var.name}"
  connection_drain_timeout     = "${var.connection_drain_timeout}"
  elb_subnet_ids               = "${var.lb_private_subnet_ids}"
  elb_security_groups          = "${var.lb_private_security_group}"
  instance_port                = "${var.instance_port}"
  instance_protocol            = "${var.instance_protocol}"
  lb_port                      = "${var.lb_port}"
  lb_protocol                  = "${var.lb_protocol}"
  elb_healthcheck_path         = "${var.elb_healthcheck_path}"
  asg_arn                      = "${module.asg_cep.asg_arn}"
}

module "r53_record" {
    source       = "../../../../modules/r53_records"
    zone_id      = "${var.internal_zone_id}"
    name         = "${var.dns_record_name}"
    elb_dns_name = "${module.elb.dns_name}"
    elb_zone_id  = "${module.elb.elb_zone_id}"
}

output "dns_name" {
  description = "DNS Records"
  value       = "${module.r53_record.r53_domain_name}"
}
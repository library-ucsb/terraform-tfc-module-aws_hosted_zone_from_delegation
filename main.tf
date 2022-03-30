# reference the fronting load balancer
data "aws_elb" "lb" {
  name 					= var.load_balancer_name
}

resource "aws_route53_zone" "zone" {
  name					= var.name
  comment				= var.comment
  delegation_set_id			= var.delegation_set_id
  force_destroy				= var.force_destroy
  tags					= var.tags
}

resource "aws_route53_record" "wildcard" {
  zone_id 				= aws_route53_zone.zone.zone_id
  name					= "*.${var.name}"
  type					= "A"

  alias {
    name				= data.aws_elb.lb.dns_name
    zone_id				= data.aws_elb.lb.zone_id
    evaluate_target_health		= true
  }
}


output "aws_elb_lb" {
  value = data.aws_elb.lb
}

output "aws_route53_zone_zone" {
  value = aws_route53_zone.zone
}


output "aws_route53_zone-arn" {
  value	= aws_route53_zone.zone.arn
}

output "aws_route53_zone-zone_id" {
  value	= aws_route53_zone.zone.zone_id
}

output "aws_route53_zone-name_servers" {
  value	= aws_route53_zone.zone.name_servers
}



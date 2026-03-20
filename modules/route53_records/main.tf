data "aws_route53_zone" "this" {
  name         = var.hosted_zone_name
  private_zone = false
}

resource "aws_route53_record" "backend_alias" {
  zone_id = data.aws_route53_zone.this.zone_id
  name    = var.backend_record_name
  type    = "A"

  alias {
    name                   = var.alb_dns_name
    zone_id                = var.alb_zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "frontend_cname" {
  zone_id = data.aws_route53_zone.this.zone_id
  name    = var.frontend_record_name
  type    = "CNAME"
  ttl     = 300
  records = [var.frontend_website_domain]
}
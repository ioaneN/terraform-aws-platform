output "backend_fqdn" {
  value = aws_route53_record.backend_alias.fqdn
}

output "frontend_fqdn" {
  value = aws_route53_record.frontend_cname.fqdn
}
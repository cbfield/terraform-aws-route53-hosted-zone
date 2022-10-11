data "aws_route53_zone" "zone" {
  count = local.create_zone ? 0 : 1

  name         = var.use_zone.name
  zone_id      = var.use_zone.id
  private_zone = coalesce(var.use_zone.private, false)
}

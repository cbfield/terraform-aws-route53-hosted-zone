locals {
  create_zone    = var.use_zone.id == null && var.use_zone.name == null
  dnssec_enabled = local.create_zone && var.dnssec.enabled
}

resource "aws_route53_zone" "zone" {
  count = local.create_zone ? 1 : 0

  comment           = var.comment
  delegation_set_id = var.delegation_set_id
  force_destroy     = var.force_destroy
  name              = var.name

  dynamic "vpc" {
    for_each = { for vpc in var.associated_vpcs : vpc.vpc_id => vpc }

    content {
      vpc_id     = vpc.value.vpc_id
      vpc_region = vpc.value.vpc_region
    }
  }

  tags = merge(var.tags, {
    "Managed By Terraform" = "true"
  })
}

resource "aws_route53_vpc_association_authorization" "auth" {
  for_each = local.create_zone ? { for auth in var.authorized_vpc_associations : auth.vpc_id => auth } : {}

  vpc_id     = each.value.vpc_id
  vpc_region = each.value.vpc_region
  zone_id    = aws_route53_zone.zone[0].id
}
